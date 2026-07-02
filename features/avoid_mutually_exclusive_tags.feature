Feature: Avoid mutually exclusive tags

  As an author of a feature file
  I want to avoid using certain tags that are mutually exclusive
  So that I do not accidentally use tags that can clash in functionalities in the Cucumber hooks during test execution

  Background:
    Given chutney is configured with the linter "Chutney::AvoidMutuallyExclusiveTags"
    And has the settings:
      """
      ---
      AvoidMutuallyExclusiveTags:
          Enabled: true
          Tags:
            - MutuallyExclusiveTag1
            - MutuallyExclusiveTag2
            - MutuallyExclusiveTag3
            - MutuallyExclusiveTag4
            - MutuallyExclusiveTag5
      """


  Scenario: Multiple feature tags that are mutually exclusive
    And a feature file contains:
      """
      @MutuallyExclusiveTag1 @MutuallyExclusiveTag2
      Feature:
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together in a feature/scenario/example: @MutuallyExclusiveTag1, @MutuallyExclusiveTag2
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |


  Scenario: Multiple scenario tags that are mutually exclusive
    And a feature file contains:
      """
      Feature:
        @MutuallyExclusiveTag1 @MutuallyExclusiveTag2
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together in a feature/scenario/example: @MutuallyExclusiveTag1, @MutuallyExclusiveTag2
      """
    And it is reported on:
      | line | column |
      | 3    | 3      |


  Scenario: Multiple example tags that are mutually exclusive
    And a feature file contains:
      """
      Feature:
        Scenario Outline:
          When I think of <topic>
          Then I am engaged in it
          @MutuallyExclusiveTag1
          Examples: First set of examples
            | topic |
            | blah  |
            | bleh  |
          @MutuallyExclusiveTag2 @MutuallyExclusiveTag3
          Examples: Second set of examples
            | topic |
            | blih  |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together in a feature/scenario/example: @MutuallyExclusiveTag1, @MutuallyExclusiveTag2, @MutuallyExclusiveTag3
      """
    And it is reported on:
      | line | column |
      | 11    | 5      |


  Scenario: Multiple tags that are mutually exclusive
    And a feature file contains:
      """
      @MutuallyExclusiveTag4
      Feature:
        @MutuallyExclusiveTag5
        Scenario Outline:
          When I think of <topic>
          Then I am engaged in it
          @MutuallyExclusiveTag1
          Examples: First set of examples
            | topic |
            | blah  |
            | bleh  |
          @MutuallyExclusiveTag2 @MutuallyExclusiveTag3
          Examples: Second set of examples
            | topic |
            | blih  |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together in a feature/scenario/example: @MutuallyExclusiveTag4, @MutuallyExclusiveTag5, @MutuallyExclusiveTag1, @MutuallyExclusiveTag2, @MutuallyExclusiveTag3
      """
    And it is reported on:
      | line | column |
      | 4    | 3      |


  Scenario: A feature tag and scenario tag that are mutually exclusive
    And a feature file contains:
      """
      @MutuallyExclusiveTag1
      Feature:
        @MutuallyExclusiveTag2
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together in a feature/scenario/example: @MutuallyExclusiveTag1, @MutuallyExclusiveTag2
      """
    And it is reported on:
      | line | column |
      | 4    | 3      |


  Scenario: A feature tag and example tag that are mutually exclusive
    And a feature file contains:
      """
      @MutuallyExclusiveTag1
      Feature:
        Scenario Outline:
          When I think of <topic>
          Then I am engaged in it
          @MutuallyExclusiveTag2
          Examples:
            | topic |
            | blah  |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together in a feature/scenario/example: @MutuallyExclusiveTag1, @MutuallyExclusiveTag2
      """
    And it is reported on:
      | line | column |
      | 7    | 5      |


  Scenario: A scenario tag and example tag that are mutually exclusive
    And a feature file contains:
      """
      Feature:
        @MutuallyExclusiveTag1
        Scenario Outline:
          When I think of <topic>
          Then I am engaged in it
          @MutuallyExclusiveTag2
          Examples:
            | topic |
            | blah  |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together in a feature/scenario/example: @MutuallyExclusiveTag1, @MutuallyExclusiveTag2
      """
    And it is reported on:
      | line | column |
      | 7    | 5      |


  Scenario: No more than one mutually exclusive tag
    And a feature file contains:
      """
      @MutuallyExclusiveTag1 @SomeOtherTag
      Feature:
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 0 issue is raised
