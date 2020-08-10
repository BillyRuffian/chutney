Feature: File Name Differs Feature Name

  As a Business Analyst
  I want the file to named after the feature
  so that feature files can be easily found
  
  Background:
    Given chutney is configured with the linter "Chutney::FileNameDiffersFeatureName"
  
  Scenario Outline: A valid example
    And a feature file called "test.feature" contains:
      """
      Feature: <name>
      """
    When I run Chutney
    Then 0 issues are raised  
    
    Examples: Valid examples
      | name |
      | test |
      | Test |
      | TEST |
    
  
  Scenario: File Name and Feature Name Differ
    And a feature file called "lint_me.feature" contains:
      """
      Feature: Test
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      The name of the feature should reflect the file name. Consider renaming this feature to 'Lint Me'.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |


  Scenario Outline: Hyphens and underscores are whitespace
    And a feature file called "lint_test.feature" contains:
      """
      Feature: <name>
      """
    When I run Chutney
    Then 0 issues are raised  
    
    Examples: Valid examples
      | name      |
      | lint test |
      | lint-test |
      | lint_test |
    
  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised