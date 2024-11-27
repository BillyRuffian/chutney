Feature: Avoid Full Stop

  As a Business Analyst
  I do not want a colon at the start of feature or scenario names
  so that it is easier to read them

  Background:
    Given chutney is configured with the linter "Chutney::AvoidColonsAtStartOfNames"

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

  Scenario: Feature name with a colon at the start
    And a feature file contains:
      """
      Feature: :Test
        Scenario: A
          When I think.
          Then I exist.
      """
    When I run Chutney
    Then 1 issues is raised
    And the message is:
      """
      Avoid using colons at the start of names, it can make them hard to read or find.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |

  Scenario: Scenario name with a colon at the start
    And a feature file contains:
      """
      Feature: Test
        Scenario: :A
          When I think.
          Then I exist.
      """
    When I run Chutney
    Then 1 issues is raised
    And the message is:
      """
      Avoid using colons at the start of names, it can make them hard to read or find.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Feature and scenaro name with a colon at the start
    And a feature file contains:
      """
      Feature: :Test
        Scenario: :A
          When I think.
          Then I exist.
      """
    When I run Chutney
    Then 2 issues are raised
    And the message is:
      """
      Avoid using colons at the start of names, it can make them hard to read or find.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |
      | 2    | 3      |
