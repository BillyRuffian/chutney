Feature: Invalid Step Flow
  
  As a Business Analyst
  I want to be warned about invalid step flow
  so that all my tests make sense

  Background:
    Given chutney is configured with the linter "Chutney::InvalidStepFlow"

  Scenario: Missing Action
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          Then verify
      """
    When I run Chutney
    Then 1 issue is raised  
    And the message is: 
      """
      This scenario is missing an action step -- it does not have a 'When'.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 2    | 3      |

  Scenario: Setup After Action
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When test
          Given setup
          Then verify
      """
    When I run Chutney
    Then 1 issue is raised  
    And the message is: 
      """
      You have a 'Given' setup step after a 'When' action step or a 'Then' assertion step. Setup steps should always be the first steps of a scenario.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 4    | 5      |

  Scenario: Action As Last Step
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          When test
          Then verify
          When test
      """
    When I run Chutney
    Then 1 issue is raised   
    And the message is: 
      """
      This scenario has the action as the last step of the scenario. A 'Then' assertion step should always follow a 'When' action step.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 6    | 5      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          Given setup
          When test
          Then verification
          When test
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised  
