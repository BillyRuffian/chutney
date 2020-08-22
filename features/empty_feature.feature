Feature: Empty feature file

  As a Business Analyst
  I do not want empty feature files 
  to avoid them being committed without tests

  Background:
    Given chutney is configured with the linter "Chutney::EmptyFeatureFile"

  Scenario: A valid example
    And a feature file contains:
      """
      Feature: Test
        Background: Preparation
          Given setup
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: An invalid example
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 1 issues are raised