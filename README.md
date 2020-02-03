<h1 align="center">
  <img src="https://raw.githubusercontent.com/BillyRuffian/chutney/master/img/chutney.svg?sanitize=true" alt="Chutney" height="200">
  <br>
  Chutney
  <br>
</h1>

<h4 align="center">
  This tool lints gherkin files
</h4>

<div align="center">

  [![Gem Version](https://badge.fury.io/rb/chutney.svg)](https://badge.fury.io/rb/chutney)
  ![CircleCI branch](https://img.shields.io/circleci/project/github/BillyRuffian/chutney/master.svg?style=flat-square)
  [![CodeFactor](https://www.codefactor.io/repository/github/billyruffian/chutney/badge?style=flat-square)](https://www.codefactor.io/repository/github/billyruffian/chutney)
  ![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/BillyRuffian/chutney.svg?style=flat-square)

</div>


## Background

This gem will sniff the Gherkin in your feature files and let you know how fresh it is.

Getting started with Cucumber is really easy but that also makes it easy to fall into some bad habits. Chutney inspects your features and let's you know if it spots anything bad.

Under the covers, Chutney uses Cucumber v3 and supports any spoken language that Cucumber does. If anyone wants to help internationalising Chutney's output, that'd be awesome.

## Usage

run `chutney` on a list of files

```
chutney '<wild_card_path>' #default is `features/**/*.feature`
```

Checks could be disabled using tags within Feature Files and the Feature or Scenario level. To do so, add `@disableCHECK`, e.g. `@disableTooManyTags`.

## Formatters

The output is rendered by formatters. Currently there are:

- RainbowFormatter (default)
- PieFormatter
- JSONFormatter

You can specify which with the `-f` flag

```
chutney f PieFormatter -f RainbowFormatter
```

![screenshot](/img/formatters.png?raw=true)


## Checks

 - [avoid outline for single example](https://github.com/BillyRuffian/chutney/blob/master/features/avoid_outline_for_single_example.feature)
 - [avoid period](https://github.com/BillyRuffian/chutney/blob/master/features/avoid_period.feature)
 - [avoid scripting](https://github.com/BillyRuffian/chutney/blob/master/features/avoid_scripting.feature)
 - [background does more than setup](https://github.com/BillyRuffian/chutney/blob/master/features/background_does_more_than_setup.feature)
 - [background requires scenario](https://github.com/BillyRuffian/chutney/blob/master/features/background_requires_scenario.feature)
 - [bad scenario name](https://github.com/BillyRuffian/chutney/blob/master/features/bad_scenario_name.feature)
 - [file name differs feature name](https://github.com/BillyRuffian/chutney/blob/master/features/file_name_differs_feature_name.feature)
 - [givens after background](https://github.com/BillyRuffian/chutney/blob/master/features/givens_after_background.feature)
 - [invalid file name](https://github.com/BillyRuffian/chutney/blob/master/features/invalid_file_name.feature)
 - [invalid step flow](https://github.com/BillyRuffian/chutney/blob/master/features/invalid_step_flow.feature)
 - [missing example name](https://github.com/BillyRuffian/chutney/blob/master/features/missing_example_name.feature)
 - [missing feature description](https://github.com/BillyRuffian/chutney/blob/master/features/missing_feature_description.feature)
 - [missing feature name](https://github.com/BillyRuffian/chutney/blob/master/features/missing_feature_name.feature)
 - [missing scenario name](https://github.com/BillyRuffian/chutney/blob/master/features/missing_scenario_name.feature)
 - [missing test action](https://github.com/BillyRuffian/chutney/blob/master/features/missing_test_action.feature)
 - [missing verification](https://github.com/BillyRuffian/chutney/blob/master/features/missing_verification.feature)
 - [same tag for all scenarios](https://github.com/BillyRuffian/chutney/blob/master/features/same_tag_for_all_scenarios.feature)
 - [scenario name must match pattern](https://github.com/BillyRuffian/chutney/blob/master/features/scenario_names_match.feature)
 - [tag used multiple times](https://github.com/BillyRuffian/chutney/blob/master/features/tag_used_multiple_times.feature)
 - [too clumsy](https://github.com/BillyRuffian/chutney/blob/master/features/too_clumsy.feature)
 - [too long step](https://github.com/BillyRuffian/chutney/blob/master/features/too_long_step.feature)
 - [too many different tags](https://github.com/BillyRuffian/chutney/blob/master/features/too_many_different_tags.feature)
 - [too many steps](https://github.com/BillyRuffian/chutney/blob/master/features/too_many_steps.feature)
 - [too many tags](https://github.com/BillyRuffian/chutney/blob/master/features/too_many_tags.feature)
 - [unique scenario names](https://github.com/BillyRuffian/chutney/blob/master/features/unique_scenario_names.feature)
 - [unknown variable](https://github.com/BillyRuffian/chutney/blob/master/features/unknown_variable.feature)
 - [use background](https://github.com/BillyRuffian/chutney/blob/master/features/use_background.feature)
 - [use outline](https://github.com/BillyRuffian/chutney/blob/master/features/use_outline.feature)

## Installation

Install it with:

`sudo gem install chutney`

After that `chutney` executable is available.

## Configuration
If you have a custom configuration you'd like to run on a regular basis instead of passing enable and disable flags through the CLI on every run, you can configure a ```.chutney.yml``` file that will be loaded on execution.  The format and available linters are in [```config/chutney.yml```](config/chutney.yml)

## Extra credit

Pickle jar image by <a href="https://pixabay.com/users/OpenClipart-Vectors-30363/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=576536">OpenClipart-Vectors</a> from <a href="https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=576536">Pixabay</a>