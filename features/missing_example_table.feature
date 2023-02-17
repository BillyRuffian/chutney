Feature: Missing Example Table

  As a Business Analyst
  I want to have at least one Examples table with the Scenario Outline
  So that the intention of the scenario is clear

  Background:
    Given chutney is configured with the linter "Chutney::MissingExampleTable"

  Scenario: Missing Examples table with the Scenario Outline
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When <A>
          Then <B>
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      Scenario Outline must have at least one Examples table.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |


  Scenario: The Examples table exists with the Scenario Outline
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When <A>
          Then <B>

          Examples: Test
            | A      | B      |
            | test A | test B |
      """
    When I run Chutney
    Then 0 issue is raised
