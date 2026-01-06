# Chutney MCP Server

> Since v3.12.0

Chutney now ships with a Model Context Protocol (MCP) server for easy integration with AI LLMs, afterall if they're helping author gherkin, it should be tasty.

The command to start the MCP is 

```bash
chutney-mcp
```

The MCP is STDIO based server.

### VS Code integration example

To set it up for a particular repository, create a file called `.vscode/mcp.json` in the root of your project. Add this block (or modify the `servers` section if you already have this file) to look like:

```json
{
  "servers": {
    "chutney": {
    "type": "stdio",
      "command": "chutney-mcp",
      "args": []
    }
  },
  "inputs": []
}
```

Then, in your copilot chat, click on tools and make sure the MCP is enabled, then click on the discover tools button and copilot will be able to use chutney.