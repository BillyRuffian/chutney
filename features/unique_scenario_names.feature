Feature: Unique Scenario Names

  As a Customer
  I want unique scenario names
  so that I can refer to them in case of issues

  Background: 
    Given chutney is configured with the linter "Chutney::UniqueScenarioNames"

  Scenario: Unique Scenario Name for empty scenarios
    And a feature file contains:
      """
      Feature: Unique Scenario Names
        Scenario: A
        Scenario: A
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The scenario name 'A' is duplicated, first used at line 2, column 3.
      """
    And it is reported on:
      | line | column |
      | 3    | 3      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Unique Scenario Names
        Scenario: A
        Scenario: B
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised
