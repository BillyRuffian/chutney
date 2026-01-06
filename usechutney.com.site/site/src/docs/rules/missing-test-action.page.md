# Missing Test Action

You have a `Scenario` or `Scenario Outline` without a `When` step. You should add a `When` step to show what the scenario is testing.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    Then I will see my account
```

## Good

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```