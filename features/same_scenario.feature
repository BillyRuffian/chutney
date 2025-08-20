@same_scenario
Feature: Same Scenario

  As a quality engineer
  I want to make sure I do not duplicate my scenarios
  So that I have a maintainable test pack

  Background:
    Given chutney is configured with the linter "Chutney::SameScenario"

    Scenario: Duplicated scenarios
      And a feature file contains:
      """
      Feature: Test
        Scenario: Scenario A
            When I do a thing
            Then A thing happens

        Scenario: Scenario A
            When I do a thing
            Then A thing happens
      """
      When I run Chutney
      Then 1 issue is raised
      And the message is:
      """
      Duplicate scenario detected: Test / Scenario A is a duplicate of Test / Scenario A
      """
      And it is reported on:
        | line | column |
        | 6    | 3      |

    Scenario: Duplicated scenarios with different names
      And a feature file contains:
        """
        Feature: Test
          Scenario: Scenario A
              When I do a thing
              Then A thing happens

          Scenario: Scenario B
              When I do a thing
              Then A thing happens
        """
      When I run Chutney
      Then 1 issue is raised
      And the message is:
        """
        Duplicate scenario detected: Test / Scenario B is a duplicate of Test / Scenario A
        """
      And it is reported on:
        | line | column |
        | 6    | 3      |


  Scenario: Duplicated scenarios ignore keywords
    And a feature file contains:
        """
        Feature: Test
          Scenario: Scenario A
              When I do a thing
              Then A thing happens

          Scenario: Scenario B
              When I do a thing
              When A thing happens
        """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
        """
        Duplicate scenario detected: Test / Scenario B is a duplicate of Test / Scenario A
        """
    And it is reported on:
      | line | column |
      | 6    | 3      |


    Scenario: Different scenarios are valid
      And a feature file contains:
        """
        Feature: Test
          Scenario: Scenario A
              When I do a thing
              Then A thing happens

          Scenario: Scenario B
              When I do a thing
              Then another thing happens
        """
      When I run Chutney
      Then 0 issues are raised

      @negative
  Scenario: Duplicated scenario outlines
    And a feature file contains:
        """
        Feature: Test
          Scenario Outline: Scenario A
              When I do a thing
              Then A thing happens
              Examples:
              | A | B |

          Scenario Outline: Scenario B
              When I do a thing
              Then A thing happens
              Examples:
              | A | B |
        """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
        """
        Duplicate scenario detected: Test / Scenario B is a duplicate of Test / Scenario A
        """
    And it is reported on:
      | line | column |
      | 8    | 3      |


  Scenario: Different examples don't raise issues
    And a feature file contains:
        """
        Feature: Test
          Scenario Outline: Scenario A
              When I do a thing
              Then A thing happens
              Examples:
              | A | B |

          Scenario Outline: Scenario B
              When I do a thing
              Then A thing happens
              Examples:
              | B | A |
        """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Duplicated scenarios with data tables
    And a feature file contains:
      """
      Feature: Test
        Scenario: Scenario A
            When I do a thing
              | A | B |
            Then A thing happens

        Scenario: Scenario A
            When I do a thing
              | A | B |
            Then A thing happens
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      Duplicate scenario detected: Test / Scenario A is a duplicate of Test / Scenario A
      """
    And it is reported on:
      | line | column |
      | 7    | 3      |

  Scenario: Different data tables do not raise issues
    And a feature file contains:
      """
      Feature: Test
        Scenario: Scenario A
            When I do a thing
              | A | B |
            Then A thing happens

        Scenario: Scenario A
            When I do a thing
              | B | A |
            Then A thing happens
      """
    When I run Chutney
    Then 0 issues are raised

    @t
  Scenario: Duplicated scenarios with doc strings
    And a feature file contains:
      """
      Feature: Test
        Scenario: Scenario A
            When I do a thing
              \"\"\"
              A docstring
              \"\"\"
            Then A thing happens

        Scenario: Scenario A
            When I do a thing
              \"\"\"
              A docstring
              \"\"\"
            Then A thing happens
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      Duplicate scenario detected: Test / Scenario A is a duplicate of Test / Scenario A
      """
    And it is reported on:
      | line | column |
      | 9    | 3      |

    @t
  Scenario: Different doc strings don't raise issues
    And a feature file contains:
      """
      Feature: Test
        Scenario: Scenario A
            When I do a thing
              \"\"\"
              A docstring
              \"\"\"
            Then A thing happens

        Scenario: Scenario A
            When I do a thing
              \"\"\"
              Some docstring
              \"\"\"
            Then A thing happens
      """
    When I run Chutney
    Then 0 issues are raised