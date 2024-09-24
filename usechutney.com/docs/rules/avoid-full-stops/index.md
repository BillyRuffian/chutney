---
title: "Avoid Full Stops"
layout: single
permalink: /docs/rules/avoid-full-stops/
---

Don't include a full stop (a period) in your steps because it makes reuse a lot harder, espcially if that step suddenly appears in the middle of a scenario.

## Bad

```gherkin
Given I have visited the website
When I log in.
Then I will see my account
```

## Good

```gherkin
Given I have visited the website
When I log in
Then I will see my account
```
