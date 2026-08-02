# {{PROJECT_NAME}} プロジェクト設定

## プロジェクト概要

{{PROJECT_DESCRIPTION}}

**執筆者**: {{RESEARCHER_NAME}}
**開始日**: {{START_DATE}}

---

## 重要な注意事項

1. **書く前に形式と評価基準を確認する**: `worksheet/constraints.md` と `worksheet/criteria.md` を
   読まずに本文を書き始めない
2. **書く前に直列化する**: 段落を書く直前に必ず `/doc-paragraph`。骨格が変わるときは `/doc-graph`
3. **一次資料から採る**: 様式・投稿規定・審査基準は発行元から直接。二次情報で代用しない
4. **点検と書き換えを混ぜない**: 点検結果を出したらいったん止め、反映範囲の指示を待つ
5. **分量の話を論理の点検に混ぜない**: 「入らないから削る」と「論理的に不要だから削る」は別
6. **Issue なしで書かない**: どの制約を満たすための変更だったかが追えなくなる
7. **調べたことは `docs/` に蓄積する**: 会話履歴に埋もれた調査は次のセッションでやり直しになる

---

## ルールの所在

| ファイル | 内容 |
|---|---|
| `template/doc-constraints.md` | 形式制約と評価基準の扱い（手順1と2） |
| `template/serialization.md` | 概念グラフと直列化（手順3）。マクロとミクロの分離 |
| `template/writing-discipline.md` | 執筆の規律。再説の禁止、用語予算、読者像 |
| `template/issue-hierarchy.md` | 文書執筆における task 構成 |
| `template/skills.md` | スキル一覧 |

**★ `.claude/rules/template/` は書き換え禁止。** プロジェクト固有の記述はこのファイルに書く。

---

## 必須コンテキスト

`worksheet/` の3ファイルは、**文章を書くすべてのスキルが着手前に必ず読む**必須コンテキスト。

| ファイル | 内容 |
|---|---|
| `worksheet/constraints.md` | 形式制約。記載項目の順序（原文引用）、分量上限、体裁 |
| `worksheet/criteria.md` | 評価基準。評定要素の一覧、評価方式、読者像 |
| `worksheet/graph.md` | 概念依存グラフ、直列化案、評定要素への対応表、欠落一覧 |

---

## 基盤テンプレートとの関係

このプロジェクトは
[research-project-template](https://github.com/AtsushiHashimoto/research-project-template)
の上に載る文書作成レイヤ。Issue 階層・worktree・コミット・レビューの機構は
そちらのスキル（`/issue-create` `/issue-start` `/issue-finish` `/commit` 等）を使う。
**ここでは重複させない。**

---

## この文書に固有の情報

<!-- 以下はプロジェクトごとに書き換える -->

- 提出先:
- 締切:
- 分量上限:
- 評価者の想定:
- 取り違えてはいけない前提:
