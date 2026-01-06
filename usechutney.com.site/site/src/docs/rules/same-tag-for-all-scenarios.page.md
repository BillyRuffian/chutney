# Same Tag For All Scenarios

You have the same tag for all scenarios. This is not recommended because it makes it difficult to filter scenarios by tags. Instead, set the tag at the \`Feature` level.

## Bad

```gherkin
Feature: Login

  @login
  Scenario: Successful login
    Given I am on the login page
    When I enter my credentials
    Then I should be logged in

  @login
  Scenario: Failed login
    Given I am on the login page
    When I enter invalid credentials
    Then I should see an error message
```

## Good

```gherkin
@login
Feature: Login

  Scenario: Successful login
    Given I am on the login page
    When I enter my credentials
    Then I should be logged in

  Scenario: Failed login
    Given I am on the login page
    When I enter invalid credentials
    Then I should see an error message
```