---
layout: default
title: Rules
parent: Usage
nav_order: 2
---

# Linting Rules

Chutney enforces its rules with the linters. These are:

[AvoidFullStop](https://github.com/BillyRuffian/chutney/blob/master/features/avoid_full_stop.feature)
: Don't have a full stop (period) at the end of step because it makes step reuse really hard.

AvoidOutlineForSingleExample
: If you only have a single example in your example table, use a plain-old scenario instead.

AvoidScripting
: You have a lot of steps, are you sure you're not scripting the scenario when you should be specifying the behaviour of the system?

BackgroundDoesMoreThanSetup
: Background in feature files should only do setup activity and so they should only contain `Given` steps.

BackgroundRequiresMultipleScenarios
: If you only have one scenario, don't bother having a Background section.

BadScenarioName
: You should avoid using words like 'test' or 'check' in your scenario names, instead you should define the behaviour of your system.

FileNameDiffersFeatureName
: The feature should have a name that follows the file name.

GivensAfterBackground
: If you have a Background section and your scenario needs more preconditions then it should start immediately with an `And` step and not another `Given`.

InvalidFileName
: Make sure your file name is in snake case, not mixed case or with spaces.

InvalidStepFlow
: Your scenarios should follow Given → When → Then, in that order.

MissingExampleName
: If you have more than one example table in your scenario, they should each be given unique names.

MissingFeatureDescription
: Your feature should have a value statement. These are usually in the form 'As a... I want.. So that...'.

MissingFeatureName
: You should give your features a descriptive name.

MissingScenarioName
: You should name your scenarios and scenario outlines.

MissingTestAction
: You don't have an action (a `When` step) in your scenario.

MissingVerification
: You don't have a verification step (a `Then` step) in your scenario.

RequiredTagsStartWith
: Chutney can enforce a configurable naming prefix for your tags.

SameTagForAllScenarios
: You have the same tag for all you scenarios; move the tag to the feature level instead.

ScenarioNamesMatch
: Chutney can enforce a naming convention for your scenario names.

TagUsedMultipleTimes
: Chutney can warn if you have used a tag a lot with a feature.

TooClumsy
: This is a very long scenario. Consider writing it more concisely.

TooLongStep
: This is a very long step. Consider writing it more concisely.

TooManyDifferentTags
: This feature has a lot of differnt tags.

TooManySteps
: This feature has a lot of steps. Consider writing it more concisely.

TooManyTags
: There are a lot of tags in this feature.

UniqueScenarioNames
: You have duplicated a scenario name when they should be unique.

UnknownVariable
: You are referencing a variable which doesn't appear to be defined. This is a source of subtle errors.

UnusedVariable
: You have a variable which you are not using.

UseBackground
: You have a setup setup used in all of your scenarios. Move it to a Background section.

UseOutline
: You have very similar scenarios. You should consider if they should be combined into a Scenario Outline.
