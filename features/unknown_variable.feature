@disableUnknownVariable
Feature: Unknown Variable

  As a Business Analyst
  I want to be warned about unknown variables
  so that I can delete them if they are not defined anymore

  Background: 
    Given chutney is configured with the linter "Chutney::UnknownVariable"

  Scenario: Unknown Step Variable
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When <baz> and <bar>

          Examples: Values
            | bar |
            | 1   |
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The variable 'baz' is referenced in your test but its value is never set.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Unknown Step Variable Even For Missing Examples
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When <baz> and <bar>
      """
    When I run Chutney
    Then 2 issues are raised 
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Unknown Table Variable
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test
           | value |
           | <baz> |

          Examples: Values
            | bar |
            | 1   |
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The variable 'baz' is referenced in your test but its value is never set.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Unknown Pystring Variable
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test
          \"\"\"
            <baz>
          \"\"\"

          Examples: Values
            | bar |
            | 1   |
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      The variable 'baz' is referenced in your test but its value is never set.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

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
