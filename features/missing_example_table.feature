Feature: Use example tables with the scenario outlines

    As a Business Analyst
    I want to have at least on example table with the scenario outlines
    So that the intention of the scenario is clear

    Background:
        Given chutney is configured with the linter "Chutney::MissingExampleTable"

    Scenario: Missing example table with the scenario outline
        And a feature file contains:
            """
        Feature: Test
            Scenario Outline: A
                When <A>
                Then <B>
            """
        When I run Chutney
        Then 1 issue is raised
        And the message is:
            """
            Scenarios outlines must have at least one example table.
            """
        And it is reported on:
            | line | column |
            | 2    | 1      |



    Scenario: The example table exists with the scenario outlines
        And a feature file contains:
            """
        Feature: Test
            Scenario Outline: A
                When <A>
                Then <B>

        Examples: Test
            | A      | B      |
            | test A | test B |
            """
        When I run Chutney
        Then 0 issue is raised