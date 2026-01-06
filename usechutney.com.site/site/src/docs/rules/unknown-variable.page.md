# Unknown Variable

You are referencing a variable which does not appear to be defined in the example table. This is probably an accident and your test might not be doing what you expect. This rule will check that all variables used in a scenario are defined in the example table.

## Bad

```gherkin
Feature: logging in

  Scenario Outline: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>" and "<admin>"
    Then I will see my account
    Then I will see my account

    Examples:
      | username | password |
      | user1    | password |
```

## Good

```gherkin
Feature: logging in

  Scenario Outline: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>" and "<admin>"
    Then I will see my account

    Examples:
      | username | password | admin |
      | user1    | password | true  |
```