---
layout: default
title: Usage
nav_order: 3
has_children: true
---

# Usage

Chutney expects to be able to find your Cucumber `.feature` files. By default, it will look for a folder called `features` in the current directory and will dig through all subfolders to find features.

You can give Chutney a path (using Ruby's globbing rules) or a single file if you want.

```
chutney '<wild_card_path>' #default is `features/**/*.feature`
```
