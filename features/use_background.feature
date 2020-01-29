Feature: Use Background

  As a Business Analyst
  I want to be warned if I'm using a background for just one scenario
  so that I am using background to improve readability

  Background:
    Given chutney is configured with the linter "Chutney::UseBackground"

  Scenario: Redundant Given Steps
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          When action
          Then verification

        Scenario: B
          Given setup
          When another action
          Then verification
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The step 'Given setup' is used in all the scenarios of this feature. It should be moved to the background steps.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |

  @disableUnknownVariable
  Scenario: Same Given in Outlines
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          Given <setup>
          When action
          Then verification

          Examples: setup
            | setup |
            | A     |

        Scenario Outline: B
          Given <setup>
          When another action
          Then verification

          Examples: setup
            | setup |
            | A     |
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The step 'Given A' is used in all the scenarios of this feature. It should be moved to the background steps.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          When action
          Then verification

        Scenario: B
          Given another setup
          When another action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised 

  @disableUnknownVariable
  Scenario: Valid Single Scenario
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          Given setup
          When <action>
          Then verification

          Examples:
            | action |
            | A      |
            | B      |
      """
    When I run Chutney
    Then 0 issues are raised 

