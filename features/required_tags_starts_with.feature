Feature: Required Tags Starts With
  As a tester I dont want to miss certain tags on my scenarios

  Background: Prepare Testee
    Given chutney is configured with the linter "Chutney::RequiredTagsStartsWith"
    And has the settings:
      """
      ---
      RequiredTagsStartsWith:
          Enabled: true
          Matcher: ['PB','MCC']
      """

    Scenario: Scenario without required tags
    And a feature file contains:
      """
      Feature: Test
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 1 issue is raised 
    And the message is: 
      """
      You have tags which do not match the required format. Allowed prefixes are 'PB, MCC'.
      """
    And it is reported on:
      | line | column |
      | 2    | 3      |

  Scenario: Scenario with PB Feature Tag
    And a feature file contains:
      """
      @PB-1234
      Feature: Test
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised  

  Scenario: Scenario with MCC feature tag
    And a feature file contains:
      """
      @MCC-1234
      Feature: Test
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised  

  Scenario: Scenario with PR Scenario tag
    And a feature file contains:
      """
      Feature: Test
        @PB-1234
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised  

  Scenario: Scenario with MCC tags
    And a feature file contains:
      """
      Feature: Test
        @MCC-1234
        Scenario: A
          When action
          Then verification
      """
    When I run Chutney
    Then 0 issues are raised

  Scenario: Defect Test - Empty Feature
    And a feature file contains:
      """
      """
    When I run Chutney
    Then 0 issues are raised
