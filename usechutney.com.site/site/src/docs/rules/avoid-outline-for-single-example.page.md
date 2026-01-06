# Avoid Outline for Single Example

If you have a Scenario Outline, but only one example, then you should convert it to a Scenario because it reduces the complexity of the feature file.

## Bad

```gherkin
Scenario Outline: Log in with valid credentials
  Given I have visited the website
  When I log in with <username> and <password>
  Then I will see my account
    Examples: of valid credentials
      | username | password |
      | user1    | pass1    |
```

## Good

```gherkin
Scenario: Log in with valid credentials
  Given I have visited the website
  When I log in with "user1" and "pass1"
  Then I will see my account
```