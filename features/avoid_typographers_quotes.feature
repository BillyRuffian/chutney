Feature: Avoid Typographers Quotes

  As a Business Analyst
  I want to be warned about using typographers quotes
  because I may have intended to use normal quotes

  Background:
    Given chutney is configured with the linter "Chutney::AvoidTypographersQuotes"

  Scenario: A valid example
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When I "think"
          Then I 'exist'
        Examples:
            | What   | Where   |
            | "here" | 'there' |
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Typographers double quote in steps
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When I “think”
          Then I 'exist'
        Examples:
            | What   | Where   |
            | "here" | 'there' |
      """
    When I run Chutney
    Then 1 issues is raised

  Scenario: Typographers single quote in steps
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When I "think"
          Then I ‘exist’
        Examples:
            | What   | Where   |
            | "here" | 'there' |
      """
    When I run Chutney
    Then 1 issues is raised

  Scenario: Typographers double quote in example
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When I "think"
          Then I 'exist'
        Examples:
            | What   | Where   |
            | “here” | 'there' |
      """
    When I run Chutney
    Then 1 issues is raised

  Scenario: Typographers single quote in steps
    And a feature file contains:
      """
      Feature: Test
        Scenario Outline: A
          When I "think"
          Then I 'exist'
        Examples:
            | What   | Where   |
            | "here" | ‘there’ |
      """
    When I run Chutney
    Then 1 issues is raised