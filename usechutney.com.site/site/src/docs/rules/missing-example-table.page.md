# Missing Example Table

You have a scenario outline without an example table. You should add an example table to the scenario outline to show what the scenario is testing, or convert the scenario outline to a scenario if you do not need to test multiple examples.

## Bad

```gherkin
Feature: logging in

  Scenario Outline: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```

## Good

```gherkin
Feature: logging in

  Scenario Outline: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account

    Examples:
      | username | password |
      | user1    | pass1    |
      | user2    | pass2    |
```