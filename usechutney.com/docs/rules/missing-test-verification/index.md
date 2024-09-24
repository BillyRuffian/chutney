---
title: "Missing Test Verification"
layout: single
permalink: /docs/rules/missing-test-verification/
---

You have a `Scenario` or `Scenario Outline` without a `Then` step. You should add a `Then` step to show what the scenario is testing.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
```

## Good

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```
