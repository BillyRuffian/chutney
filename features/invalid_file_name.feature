Feature: Invalid File Name

  As a ruby programmer
  I want the file to be in snake case
  so that it follows the conventions of the language
  
  Background:
    Given chutney is configured with the linter "Chutney::InvalidFileName"
  
  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario Outline: Using upper case in the file name
    And a feature file called "<name>.feature" contains:
      """
      Feature: Test
      """
    When I run Chutney
    Then 1 issues are raised  
    And the message is: 
      """
      Filenames of feature files should be in snake case. You should name this file '<file>'.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |
    
    Examples: Invalid examples
      | name    | file            |
      | Lint    | lint.feature    |
      | lintMe  | lint_me.feature |
      | lint me | lint_me.feature |
      | lint-me | lint_me.feature |
    
  
  Scenario: Valid example
    And a feature file called "lint.feature" contains:
      """
      Feature: Test
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised
