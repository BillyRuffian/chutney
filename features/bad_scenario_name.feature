Feature: Bad Scenario Name

  As a Business Analyst
  I want to be warned about invalid scenario names
  so that I can avoid scripted tests
  
  Background:
    Given chutney is configured with the linter "Chutney::BadScenarioName"
  
  Scenario: A valid example
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised
  
  
  Scenario Outline: Bad Scenario Names
    And a feature file contains:
      """
      Feature: Test
        Scenario: <bad word> something
      """
    When I run Chutney
    Then 1 issues are raised
    And the message is: 
      """
      You should avoid using words like '<bad word>' in your scenario names.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 2    | 3      |

    Examples: Words to avoid
      | bad word     |
      | Verifies     |
      | Verification |
      | Verify       |
      | Checks       |
      | Check        |
      | Tests        |
      | Test         |
    
