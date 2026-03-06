# Too Short Tag

If you have used a tag that is too short, you have probably done it while locally testing. This is a bad practice because it makes your tests harder to read and maintain.

It is much better to use tags that relate to the test, such as a ticket number to connect the development work you are testing

## Bad

```gherkin
@t
Scenario: Log in with valid credentials
Given I have visited the website
When I log in with "user1" and "pass1"
Then I will see my account
```

## Good

```gherkin
@QE-0001
Scenario: Log in with valid credentials
  Given I have visited the website
  When I log in with "user1" and "pass1"
  Then I will see my account
```