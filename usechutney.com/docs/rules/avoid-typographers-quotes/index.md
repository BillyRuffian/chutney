---
title: "Avoid Typographers' Quotes"
layout: single
permalink: /docs/rules/avoid-typographers-quotes/
---

Cutting and pasting from Word documents? Is that pasting in curly-quotes instead of neutral ones you would type on a keyboard? Are you sure that’s what you want?

Typographers' quotes are hard to differentiate from neutral ones in text editors but they are not the same characters and this can make it very hard to maintain feature files and their backing steps. Take a look at the 'bad' example: it's not at all obvious at first sight.

## Bad

```gherkin
Scenario: Log in with valid credentials
  When I visit the website
  Then I will see the message “account information”
```

## Good
```gherkin
Scenario: Log in with valid credentials
  When I visit the website
  Then I will see the message "account information"
```
