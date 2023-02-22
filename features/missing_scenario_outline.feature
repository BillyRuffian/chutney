Feature: Missing Scenario Outline

  As a Business Analyst
  I want to have a Scenario Outline when an Examples table is present
  So that I know it is a scenario that is run multiple times with different data

  Background:
    Given chutney is configured with the linter "Chutney::MissingScenarioOutline"

  Scenario: Scenario Outline is used when Examples table is present
    And a feature file contains:
            """
        Feature: Test
            Scenario Outline: A
                When I test
                Then I have <value>

                Examples: My Examples
                  | value  |
                  | tested |
            """
    When I run Chutney
    Then 0 issue is raised

  Scenario: Missing the word Outline when Examples table is present
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When <A>
          Then <B>

          Examples: My Examples
           | A      | B      |
           | test A | test B |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      Scenario Outline should be used instead of Scenario when there is an Examples table.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |
