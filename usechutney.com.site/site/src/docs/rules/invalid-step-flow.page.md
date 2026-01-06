# Invalid Step Flow

Scenarios should follow the Given-When-Then structure. This makes it clear to the reader what the scenario is doing and what the expected outcome is.

You should not have `Then` steps before `When` steps, or `When` steps before `Given` steps, and you should not have `Given` steps after `When` steps.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    Then I log in with "username" and 'password'
    When I will see my account
```

## Good

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "username" and "password"
    Then I will see my account
```