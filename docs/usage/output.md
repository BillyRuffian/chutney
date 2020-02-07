---
layout: default
title: Output & Exit Codes
parent: Usage
nav_order: 1
---

# Output

Chutney ships with a few formatters, the default being the Rainbow Formatter (it has coloured terminal output). Others included are the Pie Formatter which presents a textual pie chart of all the violations, and a JSON Formatter which, as is sounds, dumps the result as a JSON string.

You can specify one or formatters with the `-f` flag. For instance...

```
chutney -f RainbowFormatter -f PieFormatter -f JSONFormatter
```

## Building Your Own Formatters

Chutney expects formatters to be namespaced to the `Chutney` module and respond to `results=(results_hash)` and `format`. There is a parent class `Chutney::Formatter` which provides a few utility methods you might find useful.

Take a look a the JSONFormatter as the most minimal implementation -- it just calls `to_json` on the hash it is given.

## Exit Codes

Using the command line, Chutney returns 0 if no violations are found, 1 if one or more are found.
