# Document Project Template

A Claude Code template for writing **documents with a fixed external form** —
grant proposals, papers, standards documents, reports.

[日本語版はこちら / Japanese version](README-ja.md) — the full workflow documentation is in Japanese.

## Why

Documents with a fixed form fail for three reasons independent of the author's ability:

1. **Form violation** — the required item order, length, or formatting is not respected
2. **No correspondence to the review criteria** — the evaluator cannot find the text that answers their checklist
3. **Bad serialization** — the content is right, but the reading order makes it incomprehensible

This template fixes the procedure that clears all three *before* writing begins.

## Workflow

```
/doc-init  →  /doc-references  →  /doc-questions      (preparation)
              ↓
/doc-graph  →  /doc-outline                            (design: topic sentences first)
              ↓
( /doc-paragraph → /doc-answer N ) × number of questions   (writing)
              ↓
/doc-coverage  →  /doc-review                          (inspection)
              ↓
/doc-harvest                                           (after submission: keep the question set)
```

See [README-ja.md](README-ja.md) for the full description.

## Prerequisite

This is a **document layer on top of**
[research-project-template](https://github.com/AtsushiHashimoto/research-project-template),
which provides the Issue-driven machinery (issue hierarchy, worktrees, commits, review).

```bash
curl -fsSL https://raw.githubusercontent.com/AtsushiHashimoto/research-project-template/main/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/AtsushiHashimoto/document-project-template/main/install.sh | bash
```

## Acknowledgement

The question-set approach is inspired by
**"60 Questions & Answers"** by the Komei Sugiura Laboratory,
Department of Information and Computer Science, Keio University —
the idea that a conference paper consists of roughly 60 paragraphs,
so answering 60 questions completes the paper.
This template generalizes it by generating the question set per document
from its primary sources (form, review criteria) and authoritative secondary sources.
