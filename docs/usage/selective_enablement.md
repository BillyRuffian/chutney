---
layout: default
title: Selectively Disabling Rules
parent: Usage
nav_order: 4
---

# Selectively Disabling Rules

Sometimes you want to be able to disable linting rules for just one specific file or one specific scenario.

To do this, use the tag format `@disable<Linter Name>`. For example `@disableTooLongStep`. 

If used at the feature level, the linter will be deactivated for the whole file, used at the scenario level, only that one scenario will be excused.
