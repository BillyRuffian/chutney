# Bad Scenario Name

{: .notice}
English language only.

The name of a scenario should avoid words like 'test' and 'check'. The name should be a description of the scenario, not a statement of what it does.

## Bad

```gherkin

Scenario: checking the login
  Given I have visited the website
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