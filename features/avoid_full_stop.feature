Feature: Avoid Full Stop

  As a Business Analyst
  I do not want a period at the end of the scenario
  so that it's easier to reuse verification steps
  
  Background:
    Given chutney is configured with the linter "Chutney::AvoidFullStop"
  
  Scenario: A valid example
    And a feature file contains:
      """
        Feature: Test
          Scenario: A
            When I think
            Then I exist
      """
    When I run Chutney
    Then 0 issues are raised
  
  Scenario: Steps with a full stop
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When I think.
          Then I exist.
      """
    When I run Chutney
    Then 2 issues are raised
    And the message is: 
      """
      Avoid using a full-stop in steps so that it is easier to re-use them.
      """
    And it is reported on:
      | line | column |
      | 3    | 5      |
      | 4    | 5      |