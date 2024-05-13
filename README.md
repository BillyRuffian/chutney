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
  [![Downloads](https://img.shields.io/gem/dt/chutney)](https://rubygems.org/gems/chutney)
  ![CircleCI branch](https://img.shields.io/circleci/project/github/BillyRuffian/chutney/master.svg?style=flat-square)
  [![CodeFactor](https://www.codefactor.io/repository/github/billyruffian/chutney/badge?style=flat-square)](https://www.codefactor.io/repository/github/billyruffian/chutney)
  ![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/BillyRuffian/chutney.svg?style=flat-square)

</div>

# About

Beautiful gherkin describes the behaviour of a system in a way everyone, the customer, the business analysts, the developer, and the testers, can all understand. Rotten gherkin buries the meaning and intent of a requirement, worsens understanding, and makes the system harder to maintain.

Keep your gherkin fresh with some sensible rules and let chutney tell you if they're being followed.

# Installation

Chutney is written in ruby and should run on any [supported](https://www.ruby-lang.org/en/downloads/branches/) ruby version.

If you have a Cucumber-Ruby test pack, you can incorporate Chutney with this line in your Gemfile:

    gem 'chutney'

And then execute:

    $ bundle

Or you can install it on your system with:

    $ gem install chutney

# Configuration

Chutney comes with a built-in set of defaults and will use those if you don't provide a configuration file called `chutney.yml` or `.chutney.yml` which can live either in the root of your project or in a `config` directory. You can generate a configuration file with the command `chutney --init` and you are encouraged to do so and check the configuration works for you.

The configuration is described in a YAML file. Each rule can be enabled or disabled, a few have additional configuration options.

# Rules

<dl>
<dt>Avoid Full Stop</dt>
<dd>
Do not have a full-stop (a period for non-Commonwealth folk) at the end of a step because it makes it hard to reuse the step elsewhere.
</dd>

<dt>Avoid Outline for a Single Example</dt>
<dd>
If you only have one example, you should use a regular scenario, not a scenario outline.
</dd>

<dt>Avoid Scripting</dt>
<dd>
Are you writing a <em>lot</em> of steps? Are you writing what your application does or describing what outcome you want? You should be doing the latter so you might want to take a look at whether you are writing a script instead of a description.
</dd>

<dt>Avoid Splat Steps in Background</dt>
<dd>
Cucumber lets you list steps begining with a splat (asterisk), ostensibly to make writing lists easier as opposed to a group of steps starting with 'And'. This makes it less clear which type of step you are using (Given, When, Then) so avoid using it.
</dd>

<dt>Avoid Splat Steps in Scenarios</dt>
<dd>
Just like in background, you have have splat steps. This rule disallows that.
</dd>

<dt>Background Does More Than Setup</dt>
<dd>

</dd>

<dt>Avoid Typographers' Quotes</dt>
<dd>
Has someone cut and pasted from a word processor and now you have text which is quoted with curly-quotes? This rule warns you if that's happened so you can replace them with a typeable straight quote mark (ASCII <code>0x27</code>, HTML <code>&amp;apos;</code>)
</dd>

<dt>Background Does More Than Setup</dt>
<dd>
Background in feature files should only do setup activity and so they should only contain <code>Given</code> steps.
</dd>

<dt>Background Requires Multiple Scenarios</dt>
<dd>
If you only have one scenario, don’t bother having a Background section, roll the setup into your scenario.
</dd>

<dt>Bad Scenario Name</dt>
<dd>
You should avoid using words like ‘test’ or ‘check’ in your scenario names, instead you should define the behaviour of your system.
</dd>

<dt>Empty Feature File</dt>
<dd>
The feature should have content and you should avoid committing empty features to repositories.
</dd>


</dl>

Read the documentation [here](https://billyruffian.github.io/chutney/).

See [this page](https://billyruffian.github.io/chutney/usage/rules.html) for a full list of the rules chutney encourages.

## Notes

Chutney 3+ has replaced its direct dependency on Cucumber and instead uses the excellent [cuke_modeller](https://github.com/enkessler/cuke_modeler) to parse your feature files. 
