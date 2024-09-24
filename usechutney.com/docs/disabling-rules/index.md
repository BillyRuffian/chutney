---
title: "Disabling Rules"
layout: single
permalink: /docs/disabling-rules/
---

With all the best will and good intentions in the world, sometimes you need to break a rule. You might need to do this for a very good reason or because the rule is mis-identifing something that you think is valid.

To do this, use the tag format `@disable<Linter Name>`. For example `@disableTooLongStep`.

If used at the feature level, the linter will be deactivated for the whole file, used at the scenario level, only that one scenario will be excused.
