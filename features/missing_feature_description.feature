Feature: Missing Feature Description

  As a Customer
  I want feature descriptions
  so that I know why the features exist

  Background: 
    Given chutney is configured with the linter "Chutney::MissingFeatureDescription"

  Scenario: Missing Description
    And a feature file contains:
      """
      Feature: Test
      """
    When I run Chutney
    Then 1 issue is raised    
    And the message is: 
      """
      Features should have a description / value statement so that the importance of the feature is well understood.
      """
    And it is reported on:
      | line | column |
      | 1    | 1      |

  Scenario: Valid Example
    And a feature file contains:
      """
      Feature: Test
        As a feature
        I want to have a description,
        so that everybody knows why I exist
      """
    When I run Chutney
    Then 0 issues are raised  
