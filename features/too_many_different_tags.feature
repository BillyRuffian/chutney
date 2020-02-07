Feature: Too Many Different Tags

  As a Business Analyst
  I want that there are not that many different tags used within my specification
  so that readers do not need to know that much context

  Background:
    Given chutney is configured with the linter "Chutney::TooManyDifferentTags"

  Scenario: Many Different Tags
    And a feature file contains:
      """
      Feature: Test
        @A @B
        Scenario: A

        @C @D
        Scenario: A

        @E @F
        Scenario: A

        @G @H
        Scenario: A

        @I @J
        Scenario: A

        @K @L
        Scenario: A
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      There are too many tags in this feature. There are 12 and the maximum is 3.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |

  Scenario: Configurable maximum tag count
    And has the settings:
      """
      ---
      TooManyDifferentTags:
        Enabled: true
        MaxCount: 2
      """
    And a feature file contains:
      """
      Feature: Test
        @A @B @C
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
      | 1    | 1      |

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
