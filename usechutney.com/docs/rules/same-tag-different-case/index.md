---
title: "Same Tag Different Case"
layout: single
permalink: /docs/rules/same-tag-different-case/
---

Cucumber tags are case-sensitive. Be careful when using tags that are the same but have different cases, you might not get the results you expect if you use tags to select scenarios.

## Bad

```gherkin
Feature: logging in

  @Smoke
  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account

  @smoke
  Scenario: logging out
    Given I have visited the website
    When I log out
    Then I will see the login page
```

## Good

```gherkin
Feature: logging in
  @smoke
  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account

  @smoke
  Scenario: logging out
    Given I have visited the website
    When I log out
    Then I will see the login page
```
