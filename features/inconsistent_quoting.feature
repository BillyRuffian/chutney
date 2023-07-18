Feature: Givens After Background

  As a Business Analyst
  I want a consistent method of quoting parameters
  So that I am not confused about which values are parameters and which are not
  
  Background:
    Given chutney is configured with the linter "Chutney::InconsistentQuoting"

  Scenario: No quotations
    And a feature file contains:
      """
      Feature: Test
        Background:
          Given setup
      
        Scenario: A
          Given more setup
      """
    When I run Chutney
    Then 0 issues are raised
      
  Scenario: Single and Double Quoted Strings on the same step in a scenario
    And a feature file contains:
      """
      Feature: Test
      
        Scenario: A
          Given I "double quotes" 'single quotes'
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      Avoid using inconsistent quoting for your parameters. You have 1 single-quoted parameters (e.g. 'single quotes') and 1 double-quoted parameters (e.g. "double quotes"). You should adopt a single style to avoid confusion about the meaning and purpose of the parameters.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |
      
  Scenario: Single and Double Quoted Strings on different steps in a scenario
    And a feature file contains:
      """
      Feature: Test
      
        Scenario: A
          Given I have 'single quotes'
          When I also have "double quotes"
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      Avoid using inconsistent quoting for your parameters. You have 1 single-quoted parameters (e.g. 'single quotes') and 1 double-quoted parameters (e.g. "double quotes"). You should adopt a single style to avoid confusion about the meaning and purpose of the parameters.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |
      
  Scenario: Single and Double Quoted Strings on different scenarios
    And a feature file contains:
      """
      Feature: Test
      
        Scenario: A
          Given I have 'single quotes'

        Scenario: B
          Given I also have "double quotes"
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      Avoid using inconsistent quoting for your parameters. You have 1 single-quoted parameters (e.g. 'single quotes') and 1 double-quoted parameters (e.g. "double quotes"). You should adopt a single style to avoid confusion about the meaning and purpose of the parameters.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |
      
  Scenario: Singlular posessive apostrophes
    And a feature file contains:
      """
      Feature: Test
      
        Scenario: A
          Given user's "double quotes"

      """
    When I run Chutney
    Then 0 issues are raised
      
  Scenario: Plural posessive apostrophes
    And a feature file contains:
      """
      Feature: Test
      
        Scenario: A
          Given users' "double quotes"

      """
    When I run Chutney
    Then 0 issues are raised
      
  Scenario: Singlular posessive apostrophes within double quotes
    And a feature file contains:
      """
      Feature: Test
      
        Scenario: A
          Given "user's double quotes"

      """
    When I run Chutney
    Then 0 issues are raised
      
  Scenario: Plural posessive apostrophes within double quotes
    And a feature file contains:
      """
      Feature: Test
      
        Scenario: A
          Given "users' double quotes"

      """
    When I run Chutney
    Then 0 issues are raised
      
  