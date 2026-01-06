# Unique Scenario Names

Avoid duplicating scenario names. Scenario names should be unique within a feature file so that they are meaningful and easy to identify. This rule will check that scenario names are unique within a feature file.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```

## Good

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