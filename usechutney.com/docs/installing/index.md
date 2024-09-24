---
title: "Installing Chutney"
layout: single
permalink: /docs/installing/
---

Chutney is written in Ruby and distributed as a Ruby gem. This means you need to have Ruby installed on your system to use Chutney.

## Installing Ruby

To install Ruby, follow the instructions on the [Ruby website](https://www.ruby-lang.org/en/documentation/installation/).

## Installing Chutney

Once you have Ruby installed, you can install Chutney system-wide by running the following command:

```bash
gem install chutney
```
and update it with:

```bash
gem update chutney
```
or you can install Chutney locally by adding it to your Gemfile (you should do this if you have a Ruby-Cucumber test pack):

```ruby
gem 'chutney', "~> <latest version number>"
```
(you can grab the latest version number from the [RubyGems page](https://rubygems.org/gems/chutney).)
