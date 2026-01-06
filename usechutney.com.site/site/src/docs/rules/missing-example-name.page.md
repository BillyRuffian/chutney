# Missing Example Name

If you have more than one example table in a scenario, you should give each example a name. This makes it easier to understand what each example is testing.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "username" and "password"
    Then I will see my account

    Examples:
      | username | password |
      | user1    | pass1    |
      | user2    | pass2    |

    Examples:
      | username | password |
      | admin1   | pass1    |
      | admin2   | pass2    |
```

## Bad

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "username" and "password"
    Then I will see my account

    Examples: of regular users
      | username | password |
      | user1    | pass1    |
      | user2    | pass2    |

    Examples: of admin users
      | username | password |
      | admin1   | pass1    |
      | admin2   | pass2    |
```