<!-- [Template] document-project-template 由来。プロジェクト固有の記述は .claude/CLAUDE.md に書くこと -->

## スキル一覧

**接頭辞 `doc-` は文書作成レイヤのスキルを表す。**
Issue・コミット・レビューの機構は research-project-template のスキルを使う。

### 準備（プロジェクト開始時に一度）

| スキル | 用途 |
|-------|------|
| `/doc-init` | 形式制約と評価基準を一次資料から採取。**一文字も書く前に実行**。最後に二次資料の有無を質問する |
| `/doc-references` | 権威ある二次資料で評価軸の解釈を補強し `docs/references/` に蓄積 |
| `/doc-questions` | この文書専用の質問票を生成。既製の質問票があればそれを土台にする |
| `/doc-survey` | 文献サーベイを実施し `docs/surveys/` に残す。**存在を確認できていない文献は載せない** |

### 手順1・2: 制約の確認

| スキル | 用途 |
|-------|------|
| `/doc-constraints` | 形式制約の確認・再採取。様式・記入要領から原文を引く |
| `/doc-criteria` | 評価基準の確認・再採取。評定要素を一行ずつ表に落とす |
| `/doc-coverage` | 評定要素 → 記述箇所の対応表を作り、欠落を列挙する |

### 手順3: 直列化

| スキル | 階層 | 用途 |
|-------|------|------|
| `/doc-graph` | マクロ | 概念依存グラフ。段落レベルの順序を決める |
| `/doc-outline` | マクロ | トピックセンテンスのみ先行。縦読み検査とユーザー対話。**3節以上では必須** |
| `/doc-paragraph` | ミクロ | 段落の中を文レベルで直列化。**書く直前に毎回** |

### 執筆

| スキル | 用途 |
|-------|------|
| `/doc-answer <N>` | 質問票の1問に対話しながら答え、段落に展開する |

### 提出前・提出後

| スキル | 用途 |
|-------|------|
| `/doc-slim` | 削ぎ落とし（`slimming.md`）。一次資料の要求と反復に照らして削れる文を対話的に特定。根拠は「要求外」か「反復」のみ、1承認1コミット |
| `/doc-numbers` | 数値監査（`numbers.md` 検査a〜d: 出典突合・文書内一致・算術検算・見かけの矛盾）。数値・金額の記入直後は必ず回す。モデル指定なし |
| `/doc-readability` | 読みやすさ監査（`readability.md` 基準5〜10）。diff提案のみで適用は指示待ち。**Fable で実行**（`.claude/agents/doc-readability-reviewer.md`） |
| `/doc-review` | 形式・評価・直列化・数値・読みやすさの総点検 |
| `/doc-harvest` | 質問票を再利用資産として `docs/question-sets/` に残す |

### 実行順序

```
/doc-init → /doc-references → /doc-questions → (/doc-survey)
     → /doc-graph → /doc-outline
     → ( /doc-paragraph → /doc-answer N ) × 質問数
     → /doc-coverage → /doc-slim → /doc-numbers → /doc-readability → /doc-review → 提出 → /doc-harvest
```

骨格が変わる指摘が出たら `/doc-outline` か `/doc-graph` へ戻る。
