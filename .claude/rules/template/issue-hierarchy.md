<!-- [Template] document-project-template 由来。プロジェクト固有の記述は .claude/CLAUDE.md に書くこと -->

## 文書執筆における Issue 構成

Issue 階層（epic / task / issue の3層、ラベル運用、worktree）の機構そのものは
research-project-template に従う。ここでは**文書執筆に固有の task 構成**のみを定める。

### 既定の task 構成（必須）

```
task
 ├─ 1. constraints   形式制約と評価基準の採取・更新（/doc-init /doc-constraints /doc-criteria）
 ├─ 2. graph         概念グラフの作成・更新と全体直列化（/doc-graph）
 ├─ 3. draft         執筆。段落ごとに /doc-paragraph を伴う
 ├─ 4. coverage      評価基準への対応の点検と欠落の解消（/doc-coverage）
 └─ 5. polish        推敲・体裁・分量調整
```

省略する場合は task 本文に理由を記載する。

### 順序の制約

- **`constraints` を飛ばさない。** 版・年度が変わっていれば再採取する。
  2周目以降も skip ではなく「変更なしを確認した」記録を残す
- **`coverage` が通るまで `polish` に進まない。** 体裁を整えてから欠落が見つかると、
  分量の再配分が発生して推敲がやり直しになる
- **`graph` の指摘が骨格に及ぶ場合は `draft` を止めて `graph` に戻る。**
  骨格が動く前提で書いた本文は捨てることになる

### なぜ Issue 単位に切るのか

文書執筆は「全体を通しで直す」誘惑が強く、直すたびに他所が壊れる。
Issue 単位に切ると、変更の理由と範囲が記録に残り、
**どの制約を満たすための変更だったか**が後から追える。

とくに共著の場合、「なぜこの順序なのか」が記録されていないと、
善意の第三者が最適化された順序を壊す。
