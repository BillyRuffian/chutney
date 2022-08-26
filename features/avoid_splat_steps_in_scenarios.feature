Feature: Avoid splat steps in scenarios

  As a Business Analyst
  I want to avoid having '*' steps
  So that the intention of the scenario is clear

  Background:
    Given chutney is configured with the linter "Chutney::AvoidSplatStepsInScenarios"

  Scenario: Givens have a splat
    And a feature file contains:
      """
        Feature: 
          Scenario:
            Given I have a splat
            * this step offends the linter
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      The Scenario contains a splat step. It should only contain named steps.
      """
    And it is reported on:
      | line | column |
      | 4    | 7      |


  Scenario: Whens have a splat
    And a feature file contains:
      """
        Feature: 
          Scenario:
            Given I am a scenario
            When I have a splat step
            * this step offends the linter
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      The Scenario contains a splat step. It should only contain named steps.
      """
    And it is reported on:
      | line | column |
      | 5    | 7      |


  Scenario: Then keywords have a splat
    And a feature file contains:
      """
        Feature: 
          Scenario:
            Given I am a scenario
            When I have a splat step in a then step
            Then I am expecting a splat
            * this step offends the linter
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      The Scenario contains a splat step. It should only contain named steps.
      """
    And it is reported on:
      | line | column |
      | 6    | 7      |
