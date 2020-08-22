@disableUnknownVariable
Feature: Unused Variable

  As a Business Analyst
  I want to be warned about unused variables
  so that I can delete them if they are not used anymore or refer them again

  Background: 
    Given chutney is configured with the linter "Chutney::UnusedVariable"

  Scenario: Unused Step Variable
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When <bar>

          Examples: Values
            | bar | foo |
            | 1   | 2   |
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The variable 'foo' is declared but never used.
      """
    And it is reported on:
      | line | column |
      | 5    | 5      |

  Scenario: Unused Table Variable
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test
           | value |
           | <bar> |

          Examples: Values
            | bar | foo |
            | 1   | 2   |
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The variable 'foo' is declared but never used.
      """
    And it is reported on:
      | line | column |
      | 7    | 5      |

  Scenario: Unused Pystring Variable
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test
          \"\"\"
            <bar>
          \"\"\"

          Examples: Values
            | bar | foo |
            | 1   | 2   |
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The variable 'foo' is declared but never used.
      """
    And it is reported on:
      | line | column |
      | 8    | 5      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          Given <first>
            | value    |
            | <second> |
          When test
            \"\"\"
              <third>
            \"\"\"

          Examples: Test
            | first      | second | third |
            | used value | used   | also  |
      """
    When I run Chutney
    Then 0 issues are raised 

  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised