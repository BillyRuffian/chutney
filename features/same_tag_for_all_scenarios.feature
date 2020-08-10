Feature: Same Tag For All Scenarios

  As a Business Analyst
  I want that tags are at the level where they belong to
  so that readers are not flooded by tags

  Background: 
    Given chutney is configured with the linter "Chutney::SameTagForAllScenarios"

  Scenario: Tags used multiple times for scenario
    And a feature file contains:
      """
      Feature: Test
        @A
        Scenario: A
        @A
        Scenario: B
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      You are using the same tag (A) for all scenarios. Use this tag at the feature level instead.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |

  Scenario: Tags used multiple times for example
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test

          @A
          Examples: First
            | field |
            | value |

          @A
          Examples: Second
            | field |
            | value |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      You are using the same tag (A) for all examples in this scenario. Use this tag at the scenario level instead.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: @skip is an exception
    And a feature file contains:
      """
      Feature: Test
        @skip
        Scenario: A
        @skip
        Scenario: B
      """
    When I run Chutney
    Then 0 issues are raised  

  Scenario: Valid Example with different Tags
    And a feature file contains:
      """
      Feature: Test
        @A
        Scenario: A
        @B
        Scenario: B
      """
    When I run Chutney
    Then 0 issues are raised  

  Scenario: Valid Example with single Tag
    And a feature file contains:
      """
      Feature: Test
        @A
        Scenario: A

        Scenario: B
      """
    When I run Chutney
    Then 0 issues are raised  

  Scenario: Tags for features with single scenario
    And a feature file contains:
      """
      Feature: Test
        @A
        Scenario: A
      """
    When I run Chutney
    Then 0 issues are raised  

  Scenario: Outline even without Examples
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When test

        Scenario: B
          When test
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised
