# Avoid Mutually Exclusive Tags

Some tags are mutually exclusive by nature — they represent states or configurations that cannot coexist. For example, `@mobile` and `@desktop`, or `@en` and `@fr`.

AvoidMutuallyExclusiveTags warns you when tags from the same mutually exclusive group appear together across a feature, scenario, or examples block.

## Configuration

```yaml
AvoidMutuallyExclusiveTags:
  Enabled: true
  TagGroups:
    - - mobile
      - desktop
    - - en
      - fr
      - de
```

Each entry in `TagGroups` is a list of tags that are mutually exclusive with each other. Any two or more tags from the same group appearing together will raise an issue.

## Bad

```gherkin
@mobile @desktop
Scenario: View the homepage
  Given I have visited the website
  When I view the homepage
  Then I see the welcome message
```

```gherkin
@mobile
Feature: View the homepage
  @desktop
  Scenario: See the welcome message
    Given I have visited the website
    When I view the homepage
    Then I see the welcome message
```

```gherkin
@mobile
Feature: View the homepage
  Scenario Outline: See the welcome message in <language>
    Given I have visited the website
    When I view the homepage
    Then I see the welcome message in <language>
    @desktop
    Examples:
      | language |
      | English  |
```

## Good

```gherkin
@mobile
Scenario: View the homepage on mobile
  Given I have visited the website
  When I view the homepage
  Then I see the welcome message

@desktop
Scenario: View the homepage on desktop
  Given I have visited the website
  When I view the homepage
  Then I see the welcome message
```
