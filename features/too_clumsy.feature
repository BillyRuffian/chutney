Feature: Too Clumsy

  As a Business Analyst
  I want to write readable scenarios
  so that they are attractive enough to read

  Background:
    Given chutney is configured with the linter "Chutney::TooClumsy"

  Scenario: Long Scenario
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given something
          And another nice and shiny and green and blue thing
          And maybe still something which is also nice and shine and has a similar color
          But its color is not that nice as the color of the first thing
          When compare the colors of the both things
          And wait some time but not too long but quite a time
          And then execute it again
          Then it should be executed
          And verification should be possible
          But result shouldn't be 23
          And also not 42
          And probably also not 1337
      """
    When I run Chutney
    Then 1 issue is raised  
    And the message is: 
      """
      This scenario is too clumsy at 401 characters. Scenarios should be no more than 400 characters long.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised
