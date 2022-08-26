Feature: Avoid splat steps in background

  As a Business Analyst
  I want to avoid having '*' steps
  So that the intention of the background is clear

  Background:
    Given chutney is configured with the linter "Chutney::AvoidSplatStepsInBackground"


    Scenario: Action steps in the Background
    And a feature file contains:
      """
        Feature:
        Background:
          Given I am background
          * this step offends the linter
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      The Background contains a splat step. It should only contain named steps.
      """
    And it is reported on:
      | line | column |
      | 4    | 5      |

