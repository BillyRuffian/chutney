Feature: Too Many Steps

  As a Business Analyst
  I want to write short scenarios
  so that they are attractive enough to read

  Background:
    Given chutney is configured with the linter "Chutney::TooManySteps"


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

  Scenario: Long Scenario
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given something
          And another thing
          And maybe still something
          But not that this
          When execute it
          And wait some time
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
      There are too many steps in this feature. There are 12 and the maximum is 10.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 1    | 1      |


  Scenario: Configurable maximum tag count
    And has the settings:
      """
      ---
      TooManySteps:
        Enabled: true
        MaxCount: 2
      """
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given something
          And another thing
          And maybe still something
          But not that this
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      There are too many steps in this feature. There are 4 and the maximum is 2.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 1    | 1      |