---
title: "Too Many Steps"
layout: single
permalink: /docs/rules/too-many-steps/
---

Avoid having too many steps in a scenario. Scenarios should be concise and focused on a single behavior. This rule will check that scenarios do not have too many steps.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "validusername" and "validpassword"
    Then I will see my account
    And I will see the logout button
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
```

## Good

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "validusername" and "validpassword"
    Then I will see my account details
```
