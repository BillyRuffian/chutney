@disableTooLongStep
Feature: Background Requires Multiple Scenarios

  As a Business Analyst
  I want to be warned if I'm using a background for just one scenario
  so that I am just using background steps if it improves readability
  
  Background:
    Given chutney is configured with the linter "Chutney::BackgroundRequiresMultipleScenarios"
  
  Scenario: A valid example
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
  
  
  Scenario: Background with only one scenario
    And a feature file contains:
      """
      Feature: Test
        Background: Preparation
          Given setup

        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      Avoid using Background if you only have a single scenario.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |
