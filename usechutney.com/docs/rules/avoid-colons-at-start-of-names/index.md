---
title: "Avoid Colons at Start of Names"
layout: single
permalink: /docs/rules/avoid-colons-at-start-of-names/
---

Don't have colons at the start of feature or scenario names. It's probably a mistake if you have them from double typing the colon after the `Feature` or `Scenario` keyword.


## Bad

```gherkin
Feature: :My Feature
  Scenario: :My Scenario
    Given I have visited the website
    When I log in
    Then I will see my account
```

## Good

```gherkin
Feature: My Feature
  Scenario: My Scenario
    Given I have visited the website
    When I log in
    Then I will see my account
```
