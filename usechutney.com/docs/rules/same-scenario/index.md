---
title: "Same Scenario"
layout: single
permalink: /docs/rules/same-scenario/
---

You have a `Scenario`, or a `Scenario Outline` which appears to be duplicated. This probably means you have a redundant test. You should probably make sure you only have one copy of your steps to be consitent and efficient.


This rule ignores the names of your scenarios but takes into account data tables, examples and doc strings.

## Examples

```gherkin
Feature: Test
  Scenario: Scenario A
      When I do a thing
      Then A thing happens

  Scenario: Scenario B
      When I do a thing
      Then A thing happens
```

