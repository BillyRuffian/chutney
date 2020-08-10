Feature: Background Does More Than Setup

  As a Business Analyst
  I want to be warned if there is more than setup in background
  so that tests stay understandable
  
  Background:
    Given chutney is configured with the linter "Chutney::BackgroundDoesMoreThanSetup"
  
  Scenario: A valid example
    And a feature file contains:
      """
      Feature: Test
        Background: Preparation
          Given setup
      """
    When I run Chutney
    Then 0 issues are raised
  
  
  Scenario: Action steps in the Background
    And a feature file contains:
      """
      Feature: Test
        Background: Preparation
          Given setup
          When test
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      The Background does more than setup. It should only contain Given steps.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |
    
  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised 