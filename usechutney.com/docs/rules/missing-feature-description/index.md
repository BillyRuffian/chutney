---
title: "Missing Feature Description"
layout: single
permalink: /docs/rules/missing-feature-description/
---

You should write a description for your feature in the form of a value-statements. This makes it clear to the reader what the feature is doing and why it is important.

Value statements are short description that put the feature in context. They should be written in the form of "As a [role], I want [feature], so that [benefit]".

## Bad

```gherkin
Feature: logging in
```

## Good

```gherkin
Feature: logging in

  As a user,
  I want to log in to the website,
  so that I can access my account.
```
