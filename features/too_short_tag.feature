@too_short_tag
Feature: Too short tags

  As a quality engineer
  I want to avoid tags that are too short
  So that I can have more meaningful tags

  Background:
    Given chutney is configured with the linter "Chutney::TooShortTag"

  Scenario: Avoid single character tags
    And a feature file contains:
      """
      @t
      Feature: Test
        Scenario: A
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      Your tag is too short, avoid using single character tags. Tags should have meaning.
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |

  Scenario: Avoid single character tags: 2 singular letter tags
    And a feature file contains:
      """
      @a @b
      Feature: Test
        Scenario: B
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      Your tag is too short, avoid using single character tags. Tags should have meaning.
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |

  Scenario: Avoid single character tags: Normal tag
    And a feature file contains:
      """
      @UI
      Feature: Test
        Scenario: C
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Configurable tag length
    And has the settings:
      """
      ---
      TooShortTag:
        Enabled: true
        MinLength: 2
      """
    And a feature file contains:
      """
      @B
      Feature: Test
        Scenario: A
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is:
      """
      Your tag is too short, avoid using single character tags. Tags should have meaning.
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |

  Scenario: Configurable tag length
    And has the settings:
      """
      ---
      TooShortTag:
        Enabled: true
        MinLength: 2
      """
    And a feature file contains:
      """
      @UI
      Feature: Test
        Scenario: A
      """
    When I run Chutney
    Then 0 issues are raised