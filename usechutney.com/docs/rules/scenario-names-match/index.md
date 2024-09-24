---
title: "Scenario Names Match"
layout: single
permalink: /docs/rules/scenario-names-match/
---

This is a rule which you can configure to enforce a naming convention for scenarios. This rule will check that all scenario names match a regular expression.

## Configuration

To configure and enable this rule, you need to change your `chutney.yml` configuration file.

```yaml
ScenarioNamesMatch:
    Enabled: true
    Matcher: ^AC.*
```

This will require all scenario names to start with `AC`.

## Examples

```gherkin
Feature: logging in

  Scenario: AC-1 logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```
