Feature: Same Tag Different Case

  As a developer
  I want to have consistency in tag case
  So that I don't have unexpected results

  Background: 
    Given chutney is configured with the linter "Chutney::SameTagDifferentCase"

  Scenario: Same tag, different case
    And a feature file contains:
      """
      @foobar
      Feature: Test
        @FooBar
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 1 issue is raised    
    And the message is: 
      """
      You have a tag which has already appeared as '@foobar' which is a different case to '@FooBar'. Cucumber tags are case-sensitive: use a consistent case for your tag names.
      """
    And it is reported on:
      | line | column |
      | 4    | 3      |

  Scenario: Valid Example
    And a feature file contains:
      """
      @foobar
      Feature: Test
        @foobar
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised  