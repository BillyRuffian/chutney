Feature: Avoid tags

  As an author of a feature file
  I want to avoid using certain tags
  So that I do not accidentally commit tags that are reserved for other purposes, such as debugging

  Background:
    Given chutney is configured with the linter "Chutney::AvoidTags"
    And has the settings:
      """
      ---
      AvoidTags:
          Enabled: true
          Tags:
            - FeatureTagToAvoid
            - ScenarioTagToAvoid
            - ExamplesTagToAvoid
      """


  Scenario: Feature tag to avoid
    And a feature file contains:
      """
      @FeatureTagToAvoid
      Feature:
        Scenario:
          Given I have a splat
          * this step offends the linter
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following tags are not allowed: @FeatureTagToAvoid
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |


  Scenario: Scenario tag to avoid
    And a feature file contains:
      """
      Feature:
        @ScenarioTagToAvoid
        Scenario:
          Given I have a splat
          * this step offends the linter
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following tags are not allowed: @ScenarioTagToAvoid
      """
    And it is reported on:
      | line | column |
      | 3    | 3      |


  Scenario: Example tag to avoid
    And a feature file contains:
      """
      Feature:
        Scenario:
          Given I have a splat
          * this step offends the <target>
          @ExamplesTagToAvoid
          Examples:
            | target |
            | linter |
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      The following tags are not allowed: @ExamplesTagToAvoid
      """
    And it is reported on:
      | line | column |
      | 6    | 5      |
