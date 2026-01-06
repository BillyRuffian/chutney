# Avoid Splat Steps in Scenarios

Splat steps (using an asterisk `*`) can obscure the what kind of step is present and make it less like reading natural language.

## Bad

```gherkin
Scenario: Log in with valid credentials
  Given I have visited the website
  * I have logged in
  * I have viewed sale items
  When I view special offers
  Then I will see my discount code
```

## Good

```gherkin
Scenario: Log in with valid credentials
  Given I have visited the website
  And I have logged in
  And I have viewed sale items
  When I view special offers
  Then I will see my discount code
```