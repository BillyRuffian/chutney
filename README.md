<h1 align="center">
  <img src="https://raw.githubusercontent.com/BillyRuffian/chutney/master/img/happy_chutney.png?sanitize=true" alt="Chutney" height="200">
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

Read the documentation [here](https://www.usechutney.com/).

Your documentation is precious and should be treated as such. Chutney is a tool to help you keep your gherkin files in good shape. It will help you to write better gherkin and keep your feature files consistent through an opinionated, but optional, set of rules.

## Installation

### Ruby

Chutney is a ruby gem, so relies on you having ruby installed. It requires ruby 3.2 or later.

For macOS, Linux or other Unix-like systems, I recommend using a version manager like [rvm](https://rvm.io), [asdf](https://asdf-vm.com) or [rbenv](https://github.com/rbenv/rbenv).

For Windows, you can use [RubyInstaller](https://rubyinstaller.org/).

### Chutney

To install chutney system-wide, run:

```bash
gem install chutney
```

To install chutney for a specific project, add it to your Gemfile:

```ruby
gem 'chutney'
```

## Usage

To run chutney, simply run:

```bash
chutney
```

It will search for any `.feature` files beneath the current directory and give you an opinion. It comes with a default set of rules and will give you a little nudge if you haven't got your own chutney configuration file.

To create a configuration file, run:

```bash
chutney --init
```

(Configuration files can in either `.chutney.yml` or `.chutney.yml` and reside in the top-level of the project or in a `/config` directory.)


See [this page](https://billyruffian.github.io/chutney/usage/rules.html) for a full list of the rules chutney encourages.


## Notes

Chutney 3+ has replaced its direct dependency on Cucumber and instead uses the excellent [cuke_modeller](https://github.com/enkessler/cuke_modeler) to parse your feature files.
