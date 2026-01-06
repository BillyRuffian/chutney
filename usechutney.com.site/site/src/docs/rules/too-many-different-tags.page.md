# Too Many Different Tags

Avoid a tag soup by using too many different tags in a feature file. It suggests that redundant tags have been left in the feature file and have not been cleaned up.

## Bad

```gherkin
@tag1 @tag2 @tag3 @tag4 @tag5 @tag6 @tag7 @tag8 @tag9 @tag10
Feature: logging in

  @tag11 @tag12 @tag13 @tag14 @tag15 @tag16 @tag17 @tag18 @tag19 @tag20
  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```

## Good

```gherkin
@tag1 @tag2 @tag3
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```