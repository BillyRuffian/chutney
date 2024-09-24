---
title: "Required Tags Starts With"
layout: single
permalink: /docs/rules/required-tags-start-with/
---

This is a rule which you can configure to enforce a naming convention for tags. This rule will check that all tags on a feature start with a specific prefix.

## Configuration

To configure and enable this rule, you need to change your `chutney.yml` configuration file.

```yaml
RequiredTagsStartsWith:
    Enabled: true
    Matcher: ['JIRA','PROJECT']
```

This will require all tags to start with either `JIRA` or `PROJECT`.

## Examples

```gherkin
@JIRA-1234 @PROJECT-1
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "<username>" and "<password>"
    Then I will see my account
```
