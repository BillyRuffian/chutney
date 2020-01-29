Feature: Tag Used Multiple Times

  As a Business Analyst
  I want to use tags just once
  so that redundancy is minimized.

  Background: Prepare Testee
    Given chutney is configured with the linter "Chutney::TagUsedMultipleTimes"

  Scenario Outline: Tag used twice
    And a feature file contains:
      """
      <feature tag>
      Feature: Test
        @tag <scenario tag>
        Scenario: A
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      Avoid repeating tags at the feature and scenario level. These tags were used in both: tag.
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |
     
    Examples: Invalid Tag Combinations
      | feature tag | scenario tag |
      | @tag        |              |
      |             | @tag         |

  Scenario: Just unique tags
    And a feature file contains:
      """
      Feature: Test
        @tag_a @tag_b
        Scenario: A
      """
    When I run Chutney
    Then 0 issues are raised  
