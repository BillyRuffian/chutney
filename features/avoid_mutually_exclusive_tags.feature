Feature: Avoid mutually exclusive tag groups

  As an author of a feature file
  I want to avoid using certain groups of tags that are mutually exclusive
  So that I do not accidentally use tags that clash in specific combinations

  Background:
    Given chutney is configured with the linter "Chutney::AvoidMutuallyExclusiveTags"
    And has the settings:
      """
      ---
      AvoidMutuallyExclusiveTags:
          Enabled: true
          TagGroups:
            - - MutuallyExclusiveTag1
              - MutuallyExclusiveTag4
            - - MutuallyExclusiveTag2
              - MutuallyExclusiveTag3
              - MutuallyExclusiveTag5
      """


  Scenario: A clashing group of tags on the feature
    And a feature file contains:
      """
      @MutuallyExclusiveTag1 @MutuallyExclusiveTag4
      Feature:
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together: @MutuallyExclusiveTag1, @MutuallyExclusiveTag4
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |


  Scenario: A clashing group of tags on the scenario
    And a feature file contains:
      """
      Feature:
        @MutuallyExclusiveTag2 @MutuallyExclusiveTag3
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together: @MutuallyExclusiveTag2, @MutuallyExclusiveTag3
      """
    And it is reported on:
      | line | column |
      | 3    | 3      |


  Scenario: A clashing group of tags on the examples
    And a feature file contains:
      """
      Feature:
        Scenario Outline:
          When I think of <topic>
          Then I exist
          @MutuallyExclusiveTag4 @MutuallyExclusiveTag1
          Examples:
            | topic |
            | blah  |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together: @MutuallyExclusiveTag4, @MutuallyExclusiveTag1
      """
    And it is reported on:
      | line | column |
      | 6    | 5      |


  Scenario: A clashing group of tags across feature and scenario
    And a feature file contains:
      """
      @MutuallyExclusiveTag1
      Feature:
        @MutuallyExclusiveTag4
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together: @MutuallyExclusiveTag1, @MutuallyExclusiveTag4
      """
    And it is reported on:
      | line | column |
      | 4    | 3      |


  Scenario: A clashing group of tags across feature and examples
    And a feature file contains:
      """
      @MutuallyExclusiveTag1
      Feature:
        Scenario Outline:
          When I think of <topic>
          Then I exist
          @MutuallyExclusiveTag4
          Examples:
            | topic |
            | blah  |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together: @MutuallyExclusiveTag1, @MutuallyExclusiveTag4
      """
    And it is reported on:
      | line | column |
      | 7    | 5      |


  Scenario: A clashing group of tags across scenario and examples
    And a feature file contains:
      """
      Feature:
        @MutuallyExclusiveTag1
        Scenario Outline:
          When I think of <topic>
          Then I exist
          @MutuallyExclusiveTag4
          Examples:
            | topic |
            | blah  |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together: @MutuallyExclusiveTag1, @MutuallyExclusiveTag4
      """
    And it is reported on:
      | line | column |
      | 7    | 5      |


  Scenario: A clashing group of tags across feature, scenario and examples
    And a feature file contains:
      """
      @MutuallyExclusiveTag2
      Feature:
        @MutuallyExclusiveTag3
        Scenario Outline:
          When I think of <topic>
          Then I exist
          @MutuallyExclusiveTag5
          Examples:
            | topic |
            | blah  |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together: @MutuallyExclusiveTag2, @MutuallyExclusiveTag3, @MutuallyExclusiveTag5
      """
    And it is reported on:
      | line | column |
      | 8    | 5      |


  Scenario: Tags from different groups each raise a separate issue
    And a feature file contains:
      """
      @MutuallyExclusiveTag1 @MutuallyExclusiveTag2
      Feature:
        @MutuallyExclusiveTag3
        Scenario Outline:
          When I think of <topic>
          Then I exist
          @MutuallyExclusiveTag4
          Examples:
            | topic |
            | blah  |
      """
    When I run Chutney
    Then 2 issues are raised
    And it is reported on:
      | line | column |
      | 4    | 3      |
      | 8    | 5      |


  Scenario: Bidirectional - tag appears in group but not as first entry in chutney config
    And a feature file contains:
      """
      @MutuallyExclusiveTag4 @MutuallyExclusiveTag1
      Feature:
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following mutually exclusive tags are not allowed to be used together: @MutuallyExclusiveTag4, @MutuallyExclusiveTag1
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |


  Scenario: Non-clashing tags from different groups are allowed
    And a feature file contains:
      """
      @MutuallyExclusiveTag1 @MutuallyExclusiveTag2
      Feature:
        Scenario:
          When I think
          Then I exist
      """
    When I run Chutney
    Then 0 issue is raised
