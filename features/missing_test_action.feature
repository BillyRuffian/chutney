Feature: Missing Test Action

  As a Business Analyst
  I want to be warned if I missed an action to test
  so that all my scenarios actually stimulate the system and provoke a behavior

  Background: 
    Given chutney is configured with the linter "Chutney::MissingTestAction"

  Scenario: Missing Action
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          Then verification
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      Your test has no action step. All scenarios should have a 'When' step indicating the action being taken.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised  

  Scenario: Empty Scenario
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised
