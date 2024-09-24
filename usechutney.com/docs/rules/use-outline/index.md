---
title: "Use Outline"
layout: single
permalink: /docs/rules/use-outline/
---

You have multiple scenarios that are almost identical. This is a sign that you should use a scenario outline to define the common steps once and reuse them with different inputs. This rule will check that you are using a scenario outline when you have multiple scenarios that are almost identical.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in with user1
    Given I have visited the website
    When I log in with "user1" and "password"
    Then I will see my account

  Scenario: logging in with user2
    Given I have visited the website
    When I log in with "user2" and "password"
    Then I will see my account
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
      | user2    | password |
```
