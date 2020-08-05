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

[AvoidOutlineForSingleExample](https://github.com/BillyRuffian/chutney/blob/master/features/avoid_outline_for_single_example.feature)
: If you only have a single example in your example table, use a plain-old scenario instead.

[AvoidScripting](https://github.com/BillyRuffian/chutney/blob/master/features/avoid_scripting.feature)
: You have a lot of steps, are you sure you're not scripting the scenario when you should be specifying the behaviour of the system?

[AvoidTypographersQuotes](https://github.com/BillyRuffian/chutney/blob/master/features/avoid_typographers_quotes.feature)
: Cutting and pasting from Word documents? Is that pasting in curly-quotes instead of neutral ones you would type on a keyboard? Are you sure that's what you want?

[BackgroundDoesMoreThanSetup](https://github.com/BillyRuffian/chutney/blob/master/features/background_does_more_than_setup.feature)
: Background in feature files should only do setup activity and so they should only contain `Given` steps.

[BackgroundRequiresMultipleScenarios](https://github.com/BillyRuffian/chutney/blob/master/features/background_requires_multiple_scenarios.feature)
: If you only have one scenario, don't bother having a Background section.

[BadScenarioName](https://github.com/BillyRuffian/chutney/blob/master/features/bad_scenario_name.feature)
: You should avoid using words like 'test' or 'check' in your scenario names, instead you should define the behaviour of your system.

[FileNameDiffersFeatureName](https://github.com/BillyRuffian/chutney/blob/master/features/file_name_differs_feature_name.feature)
: The feature should have a name that follows the file name.

[GivensAfterBackground](https://github.com/BillyRuffian/chutney/blob/master/features/givens_after_background.feature)
: If you have a Background section and your scenario needs more preconditions then it should start immediately with an `And` step and not another `Given`.

[InvalidFileName](https://github.com/BillyRuffian/chutney/blob/master/features/invalid_file_name.feature)
: Make sure your file name is in snake case, not mixed case or with spaces.

[InvalidStepFlow](https://github.com/BillyRuffian/chutney/blob/master/features/invalid_step_flow.feature)
: Your scenarios should follow Given → When → Then, in that order.

[MissingExampleName](https://github.com/BillyRuffian/chutney/blob/master/features/missing_example_name.feature)
: If you have more than one example table in your scenario, they should each be given unique names.

[MissingFeatureDescription](https://github.com/BillyRuffian/chutney/blob/master/features/missing_feature_description.feature)
: Your feature should have a value statement. These are usually in the form 'As a... I want.. So that...'.

[MissingFeatureName](https://github.com/BillyRuffian/chutney/blob/master/features/missing_feature_name.feature)
: You should give your features a descriptive name.

[MissingScenarioName](https://github.com/BillyRuffian/chutney/blob/master/features/missing_scenario_name.feature)
: You should name your scenarios and scenario outlines.

[MissingTestAction](https://github.com/BillyRuffian/chutney/blob/master/features/missing_test_action.feature)
: You don't have an action (a `When` step) in your scenario.

[MissingVerification](https://github.com/BillyRuffian/chutney/blob/master/features/missing_verification.feature)
: You don't have a verification step (a `Then` step) in your scenario.

[RequiredTagsStartWith](https://github.com/BillyRuffian/chutney/blob/master/features/required_tags_starts_with.feature)
: Chutney can enforce a configurable naming prefix for your tags.

[SameTagForAllScenarios](https://github.com/BillyRuffian/chutney/blob/master/features/same_tag_for_all_scenarios.feature)
: You have the same tag for all you scenarios; move the tag to the feature level instead.

[ScenarioNamesMatch](https://github.com/BillyRuffian/chutney/blob/master/features/scenario_names_match.feature)
: Chutney can enforce a naming convention for your scenario names.

[TagUsedMultipleTimes](https://github.com/BillyRuffian/chutney/blob/master/features/tag_used_multiple_times.feature)
: Chutney can warn if you have used a tag a lot with a feature.

[TooClumsy](https://github.com/BillyRuffian/chutney/blob/master/features/too_clumsy.feature)
: This is a very long scenario. Consider writing it more concisely.

[TooLongStep](https://github.com/BillyRuffian/chutney/blob/master/features/too_long_step.feature)
: This is a very long step. Consider writing it more concisely.

[TooManyDifferentTags](https://github.com/BillyRuffian/chutney/blob/master/features/too_many_different_tags.feature)
: This feature has a lot of different tags.

[TooManySteps](https://github.com/BillyRuffian/chutney/blob/master/features/too_many_steps.feature)
: This feature has a lot of steps. Consider writing it more concisely.

[TooManyTags](https://github.com/BillyRuffian/chutney/blob/master/features/too_many_tags.feature)
: There are a lot of tags in this feature.

[UniqueScenarioNames](https://github.com/BillyRuffian/chutney/blob/master/features/unique_scenario_names.feature)
: You have duplicated a scenario name when they should be unique.

[UnknownVariable](https://github.com/BillyRuffian/chutney/blob/master/features/unknown_variable.feature)
: You are referencing a variable which doesn't appear to be defined. This is a source of subtle errors.

[UnusedVariable](https://github.com/BillyRuffian/chutney/blob/master/features/unused_variable.feature)
: You have a variable which you are not using.

[UseBackground](https://github.com/BillyRuffian/chutney/blob/master/features/use_background.feature)
: You have a setup setup used in all of your scenarios. Move it to a Background section.

[UseOutline](https://github.com/BillyRuffian/chutney/blob/master/features/use_outline.feature)
: You have very similar scenarios. You should consider if they should be combined into a Scenario Outline.
