---
title: "Givens After Background"
layout: single
permalink: /docs/rules/givens-after-background/
---

If you have a `Background` section in a feaure file and your scenarios still need to do some setup, you should start immediately with an `And` step. This makes it clear that the setup is in addition to the background and makes it obvious that the scenario is not sufficient on its own.

This is important when reading a scenario as it reminds the reader that the scenario is not self-contained.

## Bad

```gherkin
Feature: logging in

  Background:
    Given I have visited the website

  Scenario: logging in
    Given I have logged in
    When I view my profile
    Then I will see my account
```

## Good

```gherkin

Background:
    Given I have visited the website

  Scenario: logging in
    And I have logged in
    When I view my profile
    Then I will see my account
```
