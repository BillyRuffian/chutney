@disableUnknownVariable
Feature: Missing Example Name

  As a Customer
  I want examples to be named
  so that I'm able to understand why this example exists
  
  Background:
    Given chutney is configured with the linter "Chutney::MissingExampleName"

  Scenario: Missing example name when more than one example table
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test
          Then <value>

          Examples:
            | value |
            | test  |

          Examples:
            | value |
            | test  |
      """
    When I run Chutney
    Then 2 issues are raised     
    And the message is: 
      """
      You have a scenario with more than one example table, at least one of which is unnamed or has a duplicate name. You should give your example tables clear and meaningful names when you have more than one.
      """
    And it is reported on:
      | line | column |
      | 6    | 5      |
      | 10   | 5      |
    
    
  Scenario: Duplicate example name when more than one example table
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test
          Then <value>

          Examples: examples
            | value |
            | test  |

          Examples: examples
            | value |
            | test  |
      """
    When I run Chutney
    Then 2 issues are raised    
    And the message is: 
      """
      You have a scenario with more than one example table, at least one of which is unnamed or has a duplicate name. You should give your example tables clear and meaningful names when you have more than one.
      """
    And it is reported on:
      | line | column |
      | 6    | 5      |
    
  
  Scenario: Example names can be omitted with one example table
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test
          Then <value>

          Examples:
            | value |
            | test  |
      """
    When I run Chutney
    Then 0 issues are raised  
  
  Scenario: Valid example
    And a feature file called "lint.feature" contains:
      """
      Feature: Test
        Scenario Outline: A
          When stress with <list>
          And with <character>
          Then program does not crash

          Examples: Cardinality
            | list        |
            | A           |
            | A and B     |
            | A, B, and C |

          Examples: Non Ascii Characters
            | character |
            | ä         |
            | ß         |
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised
