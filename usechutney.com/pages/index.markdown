---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

# layout: single
layout: splash
permalink: /
author_profile: false

feature_row:
  - image_path: /assets/images/mr_pickle.png
    alt: "A happy jar of pickles smiling at you"
    title: "Best Practice Cucumber"
    excerpt: "Love your documentation, and your documentation will love you back."
    url: "/docs/installing/"
    btn_label: "Get Started"
    btn_class: "btn btn--success"
---

{% include feature_row type="center" %}

You’re trying to follow BDD or ATDD principles, you’re writing executable specifications in gherkin using Cucumber, you’re trying to do the *right thing* but are you doing the *thing right?*

# Tests are your documentation

Requirements are your longest-lived asset. Your implementation might change, your tests might change, but your requirements (specifications) continue to exist. They should be clear, concise, and easy to understand. They should be easy to read, easy to write, and easy to maintain. They should be your documentation.

Cucumber makes it easy to write requirements in a human-readable format. It doesn't need any tool other than a text editor to write and read. It's a great tool to write requirements in a way that everyone can understand and that can be versioned and stored in a version control system with the rest of your code.

# When cucumbers go bad

Cucumber specifications can be a great asset, but they can also be a liability. In the exchange between business language and the language of testers and software developers, it's easy to lose the meaning of the requirements. It's easy to write specifications that are hard to read, hard to write, and hard to maintain.

Chutney helps you write better Cucumber specifications. It helps you write specifications that are clear, concise, and easy to understand. It helps you write specifications that are easy to read, easy to write, and easy to maintain. Be kind to your future self and your team. Love your documentation, and your documentation will love you back.

# What is Chutney?

Chutney is a Ruby tool that reads your Cucumber feature files and tells you how you can make them better. It's a linter for Cucumber. It will help you avoid common pitfalls and anti-patterns in your Cucumber feature files. It will help you write better Cucumber specifications.

Chutney is able to lint feature files in any spoken language supported by Cucumber.
