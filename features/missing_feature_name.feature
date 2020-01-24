Feature: Missing Feature Name

  As a Customer
  I want named features
  so that I know what the feature is about just by reading the name

  Background: 
    Given chutney is configured with the linter "Chutney::MissingFeatureName"

  Scenario: Missing Feature Name
    And a feature file contains:
      """
      Feature:
      """
    When I run Chutney
    Then 1 issue is raised
    And the message is: 
      """
      This feature is unnamed. You should name all features.
      """
    And it is reported on on <line> <column>
      | line | column |
      | 1    | 1      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
      """
    When I run Chutney
    Then 0 issues are raised  
