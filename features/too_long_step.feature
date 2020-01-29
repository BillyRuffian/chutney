Feature: Too Long Step

  As a Business Analyst
  I want to write short steps
  so that they are attractive enough to read

  Background: 
    Given chutney is configured with the linter "Chutney::TooLongStep"

  Scenario: Long Step
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When action is quite long so that is not very readable and people even need to scroll because it does not fit on the screen
          Then verification
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      This step is too long at 118 characters. It should be no longer than 80  characters.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |
      
  Scenario: Configurable step length
    And has the settings:
      """
      ---
      TooLongStep:
        Enabled: true
        MaxLength: 20
      """
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When the step is longer than 20 characters
      """
    When I run Chutney
    Then 1 issue is raised  

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised  
