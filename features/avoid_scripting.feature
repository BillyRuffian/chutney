Feature: Avoid Scripting

  As a Business Analyst
  I want to be warned about scripted tests
  so that all my tests follow the guideline of single action per scenario.
  
  Background:
    Given chutney is configured with the linter "Chutney::AvoidScripting"
  
  Scenario: A valid example
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When I think
          Then I exist
      """
    When I run Chutney
    Then 0 issues are raised
  
  
  Scenario: Multiple Actions
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          When action
          And something else
          Then verify
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      You have 2 When steps when you should only have one. Be careful not to add And steps following a When.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 5    | 5      |
    
    
  Scenario: Repeat Action-Verfication Steps
    Given a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          When test
          Then verify
          When test
          Then verify
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      You have 2 When steps when you should only have one. Be careful not to add And steps following a When.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 6    | 5      |