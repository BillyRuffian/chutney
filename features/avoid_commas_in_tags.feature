Feature: Avoid commas in tags

  As a tester
  I want to avoid commas in tags
  So that I can use them to separate tags in the tag list

  Background:
    Given chutney is configured with the linter "Chutney::AvoidCommaInTags"

  Scenario: Avoid commas in tags
    And a feature file contains:
      """
      @comma,
      Feature: Test
        Scenario: A
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      Avoid using commas in tags. Tags should be separated by spaces.
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |
