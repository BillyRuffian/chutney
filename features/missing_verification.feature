Feature: Missing Verification

  As a Business Analyst
  I want that each test contains at least one verification
  so that I'm sure that the behavior of the system is tested

  Background:
    Given chutney is configured with the linter "Chutney::MissingVerification"

  Scenario: Missing assertion step
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          When test
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      Your test has no verification step. All scenarios should have a 'Then' step indicating the assertion being tested.
      """
    And it is reported on on <line> <column>
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
