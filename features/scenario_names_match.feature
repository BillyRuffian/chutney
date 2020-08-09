Feature: Scenario Names Match

  As a tester 
  I want my scenario names to match a pattern
  So that I link acceptance criteria to scenarios
  
  Background: Prepare Testee
    Given chutney is configured with the linter "Chutney::ScenarioNamesMatch"
    And has the settings:
      """
      ---
      ScenarioNamesMatch:
          Enabled: true
          Matcher: ^AC.*
      """
      
    Scenario: Scenario without required name
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 1 issue is raised  
    And the message is: 
      """
      You have a scenario name which does not match the required format. Allowed patterns are '^AC.*'.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |
      
    Scenario: Scenario with name starting AC
    And a feature file contains:
      """
      Feature: Test
        Scenario: AC - scenario
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised
    
    Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised
