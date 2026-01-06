# Too Clumsy

Avoid having very long or wordy scenarios. They are difficult to read and maintain and are often a sign that the scenario is doing too much or there is scripting involved. This rule will checks the total number of character in a scenario.

## Bad

```gherkin
Feature: logging in

  Scenario: logging in with a valid username and password
    Given I have visited the website
    When I log in with "validusername" and "validpassword"
    Then I will see my account
    And I will see the logout button
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
    And I will see the account address
    And I will see the account phone number
    And I will see the account email
    And I will see the account status
    And I will see the account type
    And I will see the account currency
    And I will see the account balance
    And I will see the account number
    And I will see the account name
```

## Good

```gherkin
Feature: logging in

  Scenario: logging in
    Given I have visited the website
    When I log in with "validusername" and "validpassword"
    Then I will see my account details
```