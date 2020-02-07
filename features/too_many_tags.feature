Feature: Too Many Tags

  As a Business Analyst
  I want that scenarios are not tagged by too many tags
  so that readers can concentrate on the content of the scenario

  Background:
    Given chutney is configured with the linter "Chutney::TooManyTags"

  Scenario: Many Tags
    And a feature file contains:
      """
      @A
      Feature: Test
        @B @C @D
        Scenario: A
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      There are too many tags in this feature. There are 4 and the maximum is 3.
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |

  Scenario: Valid Example
    And a feature file contains:
      """
      @A
      Feature: Test
        @B @C
        Scenario: A
      """
    When I run Chutney
    Then 0 issues are raised 

  Scenario: Configurable number of tags
    And has the settings:
      """
      ---
      TooManyTags:
        Enabled: true
        MaxCount: 2
      """
    And a feature file contains:
      """
      @A
      Feature: Test
        @B @C
        Scenario: A
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      There are too many tags in this feature. There are 3 and the maximum is 2.
      """
    And it is reported on:
      | line | column |
      | 2    | 1      |