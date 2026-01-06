# Chutney Language Server

> Since v3.8.0

Chutney now includes a Language Server (LSP), which can be used with your favourite editor to provide real-time feedback on your feature files.

The command to start the Language Server is:

```bash
chutney-lsp
```

The language server will consume from the standard input and emit to standard output. This means that you can use it with any editor that supports the LSP protocol.

It will listen for open / close and save events to evaluate the current feature file and provide feedback.

## Editor integrations

### VS Code

[vscode-chutney](https://github.com/BillyRuffian/vscode-chutney) adds Chutney LSP integration into VS Code, 

You can install this extension from the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=NigelBrookes-Thomas.vscode-chutney).