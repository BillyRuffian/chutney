# File Name Differs From Feature Name

The name of a feature file should match the name of the feature it describes. This makes it easier to find the feature file that contains a specific scenario.

Case and punctuation can vary between the feature name and the file name, but the words should match.

## Bad

{: .notice}
`user.feature`

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in
    Then I will see my account
```

## Good

{: .notice}
`logging-in.feature`

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in
    Then I will see my account
```