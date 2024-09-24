---
title: "Chutney Language Server"
layout: single
permalink: /docs/language-server/
---

{: .notice}
Since v3.8.0

Chutney now includes a Language Server (LSP), which can be used with your favourite editor to provide real-time feedback on your feature files.

The command to start the Language Server is:

```bash
chutney-lsp
```

The language server will consume from the standard input and emit to standard output. This means that you can use it with any editor that supports the LSP protocol.

It will listen for open / close and save events to evaluate the current feature file and provide feedback.

## Editor integrations

TBD.
