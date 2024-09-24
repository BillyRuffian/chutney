---
title: "Missing Scenario Outline"
layout: single
permalink: /docs/rules/missing-scenario-outline/
---

You have a `Scenario` with an example table, but you should use a `Scenario Outline` instead. This makes it clear to the reader that the scenario is a template for multiple examples.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account

    Examples:
      | username | password |
      | user1    | pass1    |
      | user2    | pass2    |
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
      | user1    | pass1    |
      | user2    | pass2    |
```
