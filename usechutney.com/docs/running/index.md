---
title: "Running Chutney"
layout: single
permalink: /docs/running/
---

Once you have [installed Chutney](/docs/installing/), you can run it from the command line.

```bash
chutney
```

This will run Chutney in the current directory where it will look for a folder called `features` and check all the `.feature` files in it. If you want to run Chutney on a specific file, you can specify that on the command line:

```bash
chutney path/to/your/file.feature
```

## Results

Chutney will output a list of any issues it finds in your feature files. If it finds no issues, it will output a message that all your features are delicious.

For example:

```text
foo.feature
  MissingTestAction
    Your test has no action step. All scenarios should have a 'When' step indicating the action being taken.
    foo.feature:13
  MissingScenarioName
    This scenario is unnamed. You should name all scenarios.
    foo.feature:13
```
