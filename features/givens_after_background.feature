Feature: Givens After Background

  As a Business Analyst
  I want prerequisites in scenarios to begin with an 'And' if there is a Background
  So that it is clear that other setup activity happens
  
  Background:
    Given chutney is configured with the linter "Chutney::GivensAfterBackground"
  
  Scenario: Givens after Background
    And a feature file contains:
      """
      Feature: Test
        Background:
          Given setup
      
        Scenario: A
          Given more setup
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      Avoid using the 'Given' keyword in scenarios if you have a background. Instead, setup steps begin your scenario and should start with an 'And' or 'But' keyword.
      """
    And it is reported on:
      | line | column |
      | 6    | 5      |
      
  Scenario: Givens after Background as a subsequent step
    And a feature file contains:
      """
      Feature: Test
        Background:
          Given setup
      
        Scenario: A
          And more setup
          Given yet more setup
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      Avoid using the 'Given' keyword in scenarios if you have a background. Instead, setup steps begin your scenario and should start with an 'And' or 'But' keyword.
      """
    And it is reported on:
      | line | column |
      | 7    | 5      |
      
  Scenario: Ands after Background
    And a feature file contains:
      """
      Feature: Test
        Background:
          Given setup
      
        Scenario: A
          And more setup
      """
    When I run Chutney
    Then 0 issues are raised
      
  Scenario: Buts after Background
    And a feature file contains:
      """
      Feature: Test
        Background:
          Given setup
      
        Scenario: A
          But more setup
      """
    When I run Chutney
    Then 0 issues are raised