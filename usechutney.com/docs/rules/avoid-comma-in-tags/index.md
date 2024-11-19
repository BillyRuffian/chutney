---
title: "Avoid Comma in Tags"
layout: single
permalink: /docs/rules/avoid-comma-in-tags/
---

Don't put a comma in tags. It's probably a mistake if you have them from trying write a list of tags but the comma will form part of the name and makes it hard to include or exclude the tag from a Cucumber run.


## Bad

```gherkin
@web, @login
Given I have visited the website
When I log in.
Then I will see my account
```

## Good

```gherkin
@web @login
Given I have visited the website
When I log in
Then I will see my account
```
