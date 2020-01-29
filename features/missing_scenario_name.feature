Feature: Missing Scenario Name

  As a Customer
  I want named scenarios
  so that I know what this scenario is about without reading it

  Background:
    Given chutney is configured with the linter "Chutney::MissingScenarioName"

  Scenario: Missing Scenario Name
    And a feature file contains:
      """
      Feature: Test
        Scenario:
      """
    When I run Chutney
    Then 1 issue is raised  
    And the message is: 
      """
      This scenario is unnamed. You should name all scenarios.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Missing Scenario Outline Name
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline:
      """
    When I run Chutney
    Then 1 issue is raised   
    And the message is: 
      """
      This scenario is unnamed. You should name all scenarios.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
      """
    When I run Chutney
    Then 0 issues are raised  
