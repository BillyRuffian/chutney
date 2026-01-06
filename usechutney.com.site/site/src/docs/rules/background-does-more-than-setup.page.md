# Background Does More Than Setup

The `Background` should only perform common setup activities to prepare the scenarios that follow. They should not contain any `When` or `Then` steps, only `Given`.

## Bad

```gherkin
Background:
  Given I have visited the website
  When I log in

Scenario: logging in
  Then I will see my account
```

## Good
```gherkin
Background:
  Given I have visited the website

Scenario: logging in
  When I log in
  Then I will see my account
```