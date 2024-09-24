---
title: "Too Long Step"
layout: single
permalink: /docs/rules/too-long-step/
---

Avoid having very long or wordy steps. They are difficult to read and maintain and are often a sign that the step is doing too much or there is scripting involved. This rule will check that steps are not too long. Having an 'and' inside the step is often a clue that you have a compound step that should be broken down into smaller steps.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website and  successfully logged in with a user account having the credentials "validusername" and "validpassword"
    When I view my profile
    Then I will see my account
```

## Good

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    And I have logged with credentials "validusername" and "validpassword"
    When I view my profile
    Then I will see my account
```
