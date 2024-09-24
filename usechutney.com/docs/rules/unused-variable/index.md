---
title: "Unused Variable"
layout: single
permalink: /docs/rules/unused-variable/
---

You have defined a variable in your example table but you are not using it. This is probably an accident and your test might not be doing what you expect. This rule will check that all variables defined in the example table are used in the scenario.

## Bad

```gherkin
Feature: logging in

  Scenario Outline: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account

    Examples:
      | username | password | admin |
      | user1    | password | true  |
```

## Good

```gherkin
Feature: logging in

  Scenario Outline: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account

    Examples:
      | username | password |
      | user1    | password |
```
