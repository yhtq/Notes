#import "../template.typ": *
#show: note.with(
  withChapterNewPage: false,
  withOutlined: false,
  withTitle: false,
  withHeadingNumbering: false,
)
= Introduction
- Scripting language consumes much time on waiting for external call, which makes traditional optimization ineffective.
- We propose a novel _opportunistic_ evaluation strategy that automatically dispatches independent external calls in parallel.
- By assuming that external calls can be fully determined by the call arguments