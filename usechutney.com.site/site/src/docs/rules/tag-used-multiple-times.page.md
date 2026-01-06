# Tag Used Multiple Times

Avoid using the same tag at both the feature and scenario level. If it is used at the feature level it is redundant at the scenario level. This rule will check that tags are not used multiple times in the same feature file.

## Bad

```gherkin
@tag
Feature: logging in

  @tag
  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```

## Good

```gherkin
@tag
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```