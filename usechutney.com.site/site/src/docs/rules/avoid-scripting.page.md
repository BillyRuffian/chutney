# Avoid Scripting

If you find yourself needing to write more than one `when` step, you a probably scripting. This is a bad practice because it makes your tests harder to read and maintain. It also makes it harder to debug when something goes wrong.

It is much better to describe what outcome should happen in your steps and let the automation code handle the implementation details. This makes your tests more readable and easier to maintain.

## Bad

```gherkin
Scenario: Log in with valid credentials
  Given I have visited the website
  When I click the log in button
  And I enter "user1" in the username field
  And I enter "pass1" in the password field
  And I click the submit button
  Then I will see my account page
  And I will see my username
  And I will see my profile picture
  And I will see my account balance
```

## Good

```gherkin
Scenario: Log in with valid credentials
  Given I have visited the website
  When I log in with "user1" and "pass1"
  Then I will see my account
```