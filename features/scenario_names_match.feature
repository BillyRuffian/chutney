Feature: Required Tags Starts With
  As a tester I dont want my scenario names to match a pattern
  
  Background: Prepare Testee
    Given a file named ".chutney.yml" with:
      """
      ---
      ScenarioNamesMatch:
          Enabled: true
          Matcher: ^AC.*
      """
    And a file named "lint.rb" with:
      """
      $LOAD_PATH << '../../lib'
      require 'chutney'

      linter = Chutney::ChutneyLint.new
      linter.disable_all
      linter.enable %w(ScenarioNamesMatch)
      linter.set_linter
      linter.analyze 'lint.feature'
      exit linter.report

      """
      
    Scenario: Scenario without required name
      Given a file named "lint.feature" with:
      """
      Feature: Test
        Scenario: A
          When action
          Then verification
      """
      When I run `ruby lint.rb`
      Then it should pass with exactly:
      """
      ScenarioNamesMatch (Warning) - Scenario Name does not match pattern
        lint.feature (2): Test.A

      """
      
    Scenario: Scenario with name starting AC
    Given a file named "lint.feature" with:
      """
      Feature: Test
        Scenario: AC - scenario
          When action
          Then verification
      """
    When I run `ruby lint.rb`
    Then it should pass with exactly:
      """
      """