---
name: template-contribute
description: プロジェクトで育った規律・スキルを document-project-template へ還流する（テンプレートへの改善PR）。テンプレート由来パスのローカル改変を検出し、1件ずつ確認してから PR を作る。
---

# Template Contribute（テンプレートへの改善PR）

テンプレート由来ファイルへのローカル改変を検出し、テンプレートリポジトリへの PR として還流する。
research-project-template の同名スキルを文書プロジェクト向けに簡略化したもの。

## 用途

- 執筆中に足した規律（`.claude/rules/template/*.md`）をテンプレートへ戻す
- 新しいスキル・エージェント定義をテンプレートに追加提案する

**規律は文書を1本書くたびに増える。戻さないと次のプロジェクトでまた一から失敗する。**
提出後（`/doc-harvest` のあと）に必ず一度回す。

## ★ 判別基準

**テンプレート由来パスの変更＝還流候補。それ以外＝プロジェクト固有（還流しない）。**
基準はパスで機械的に決める。

| 還流候補（テンプレート由来） | 対象外（プロジェクト固有） |
|---|---|
| `.claude/rules/template/` | `.claude/rules/` 直下（ローカルルール） |
| `.claude/skills/` | `.claude/CLAUDE.md` |
| `.claude/agents/` | `.claude/template-source.json`（fork 先の URL） |
| `.claude/scripts/` | `worksheet/`, `docs/`, 本文、その他すべて |
| `.claude/rules/template.bak-*/`（sync が退避したローカル改変） | |

判別と diff 生成の実体は **`.claude/scripts/template-contribute-detect.sh`**。
このリストを SKILL.md 側に書き写して二重管理しない（単一情報源）。

## Workflow

### Step 1: テンプレートの最新版を clone

**取得に失敗したら、そこで中止する。** 部分適用も無言終了もしない。
URL は `.claude/template-source.json` が正で、読み取りは `.claude/scripts/template-source.sh`。

```bash
TEMPLATE_REPO=$(bash .claude/scripts/template-source.sh)
PROJECT_ROOT=$(git rev-parse --show-toplevel)
TMP_DIR=$(mktemp -d)
git clone --depth 1 "$TEMPLATE_REPO" "$TMP_DIR/template" || { echo "取得失敗" >&2; exit 1; }
```

### Step 2: 還流候補の検出

```bash
bash .claude/scripts/template-contribute-detect.sh --source "$TMP_DIR/template"
```

`[変更]` はテンプレートにも存在するが内容が違う、`[追加]` はローカルにのみ存在する。
候補が 0 件ならここで終了する。

### Step 3: 1件ずつ提示し、選択を受ける

**候補は一度に1件だけ出す**（`writing-discipline.md`「一度に出すのは1件」）。
差分が長いときは、追加された節の見出しを表にし、全文は求められたら出す。

```bash
bash .claude/scripts/template-contribute-detect.sh --source "$TMP_DIR/template" --diff "<パス>"
```

各候補に「汎用的な改善か、このプロジェクト固有か」を問う。
**ユーザーの選択なしに PR を作らない。** 選ばれたパスを `SELECTED_FILES` に集める。

### Step 4: 固有内容の汚染チェック（必須）

テンプレートへ入るファイルは、他の文書プロジェクトでそのまま読めなければならない。

- 文書の題材（研究課題名、機関名、人名、金額、年度）が規律の本文に入っていないか grep する
- **実例の帰属（`橋本 2026-09-08` のような日付と名前）は慣例として許す。**
  テンプレートの既存の節が同じ書き方をしているため。ただし実例は、
  その文書を知らない読者にも規律の説明として読める形にする
- 検出されたら、該当箇所を汎用の表現に置き換えてから続行する

### Step 5: 内容の見直し（必須）

テンプレートの他の節と矛盾しないかを、選んだファイルごとに一度読む。

- 新しい規律が既存の規律と衝突していないか（例: 例示の語が新規律に反していないか）
- スキルを足す場合、参照しているスキル・スクリプト・ファイルがテンプレート側に存在するか
- research-project-template 由来のものは、`.spec/`、`/review`、issue 機構への言及を落とす

### Step 6: ブランチを作って反映

```bash
cd "$TMP_DIR/template"
git checkout -b "contribute/$(date +%Y%m%d)-<topic>"
for f in $SELECTED_FILES; do mkdir -p "$(dirname "$f")"; cp "$PROJECT_ROOT/$f" "$f"; done
# MANIFEST.sha256 を持つテンプレートなら再生成する
[ -f .claude/rules/template/MANIFEST.sha256 ] && \
  bash .claude/scripts/generate-rules-manifest.sh .claude/rules/template
```

`template.bak-<日時>/template/<rel>` を選んだ場合の反映先は `.claude/rules/template/<rel>`。

### Step 7: PR を作る

PR 本文には次の3項目を必ず書く。書けない変更は還流しない。

| 項目 | 内容 |
|---|---|
| **動機** | どんな失敗・不便があって直したのか。実例があれば書く |
| **汎用性の根拠** | なぜ他の文書プロジェクトにも当てはまるのか（ユーザーに確認する。推測で埋めない） |
| **変更ファイル** | 選んだパスの一覧 |

```bash
git add -A && git commit -m "feat: <改善の要約>"
git push -u origin "$(git branch --show-current)"
gh pr create --repo "$TEMPLATE_REPO" --title "feat: <改善の要約>" --body "<上の3項目>"
```

### Step 8: クリーンアップ

```bash
rm -rf "$TMP_DIR"
```

## Note

- 逆方向（テンプレートの更新を取り込む）は、このテンプレートにはまだスキルがない。
  `git diff` で `.claude/rules/template/` を突き合わせて手で取り込む
- GitHub 認証が要る（`gh auth status`）
