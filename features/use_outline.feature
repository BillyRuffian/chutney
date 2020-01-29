Feature: Use Outline

  As a Business Analyst
  I want to be warned if I'm using a background for just one scenario
  so that I am using background to improve readability

  Background: 
    Given chutney is configured with the linter "Chutney::UseOutline"

  Scenario: Similar Scenarios
    And a feature file contains:
      """
      Feature: Test
        Background: Preparation
          Given setup

        Scenario: A
          When action 1
          Then verification

        Scenario: B
          When action 2
          Then verification
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      Scenarios are similar by 97.8%, you should use scenario outlines to simplify.  Scenario: A (5) vs Scenario: B (9)
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |

  Scenario: Empty Scenarios
    And a feature file contains:
      """
      Feature: Test
        Background: Preparation
          Given setup

        Scenario: A

        Scenario: B
      """
    When I run Chutney
    Then 0 issues are raised 

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        Background: Preparation
          Given setup

        Scenario: A
          When action
          Then verification

        Scenario: B
          When another action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised 
