---
title: "Inconsistent Quoting"
layout: single
permalink: /docs/rules/inconsistent-quoting/
---

Use either single or double quotes consistently throughout your feature files. This makes it clear to the reader where your strings and variables are.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "username" and 'password'
    Then I will see my account
```

## Good

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "username" and "password"
    Then I will see my account
```
