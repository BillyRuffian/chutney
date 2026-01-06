# Avoid Splat Steps in Background

Splat steps (using an asterisk `*`) can obscure the what kind of step is present and make it less like reading natural language.

## Bad

```gherkin
Background:
  Given I have visited the website
  * I have logged in
  * I have viewed sale items
```

## Good

```gherkin
Background:
  Given I have visited the website
  And I have logged in
  And I have viewed sale items
```