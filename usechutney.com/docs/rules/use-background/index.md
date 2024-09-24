---
title: "Use Background"
layout: single
permalink: /docs/rules/use-background/
---

You have multiple scenarios that all have the same setup steps. This is a sign that you should use a background to define the common setup steps once and reuse them in each scenario. This rule will check that you are using a background when you have multiple scenarios with the same setup steps.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account

  Scenario: logging out
    Given I have visited the website
    When I log out
    Then I will see the login page
```

## Good

```gherkin
Feature: logging in

  Background:
    Given I have visited the website

  Scenario: logging in
    When I log in with "<username>" and "<password>"
    Then I will see my account

  Scenario: logging out
    When I log out
    Then I will see the login page
```
