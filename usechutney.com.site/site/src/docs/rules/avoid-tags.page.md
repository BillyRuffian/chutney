# Avoid Tags

Sometimes you just need a tag for you... maybe to filter your scenarios for focused testing?... or maybe you've got some fancy after hook to help with debugging? 
Whatever the reason, you probably didn't mean to commit that to source. 

AvoidTags helps prevent the accidental commit of tags by warning you if you have any tags in your feature file which match a configurable list of tags to avoid.

## Configuration

```yaml
AvoidTags:
  Enabled: true
  Tags:
    - MyFancyDebugTag
```

## Bad

```gherkin
@MyFancyDebugTag
Scenario: Log in with valid credentials
  Given I have visited the website
  And I have logged in
  And I have viewed sale items
  When I view special offers
  Then I will see my discount code
```

## Good

```gherkin
Scenario: Log in with valid credentials
  Given I have visited the website
  And I have logged in
  And I have viewed sale items
  When I view special offers
  Then I will see my discount code
```