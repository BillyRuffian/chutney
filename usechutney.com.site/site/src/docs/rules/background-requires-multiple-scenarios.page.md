# Background Requires Multiple Scenarios

If you only have one scenario, you don't need a `Background`. The `Background` should only be used when you have multiple scenarios that share the same setup steps.

## Bad

```gherkin
Background:
  Given I have visited the website

Scenario: logging in
  When I log in
  Then I will see my account
```

## Good
```gherkin
Scenario: logging in
  Given I have visited the website
  When I log in
  Then I will see my account
```