---
title: "Invalid File Name"
layout: single
permalink: /docs/rules/invalid-file-name/
---

The name of the feature file should be in `snake_case` and end with `.feature`. It should not be in `mixedCase` or contain spaces. This makes sure that the feature file can easily be found on different types of operating system which have different file naming conventions.

## Bad

{: .notice}
`Logging In.feature`
<br/>
`logginIn.feature`

## Good

{: .notice}
`logging_in.feature`
