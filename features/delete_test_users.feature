Feature: Delete test users

  In order to be able to run registration tests<br/>
  Attempt to delete those test users which have already been created

  Background:
    Given a login page open

  Scenario Outline: Looping through test user list, logging in using their credentials and then deleting their accounts
    Given logged in as "<username>" with password "<password>"
    When deleting account
    Then the account is deleted

    Examples:
      | username    | password           |
      | TestUser1   | TestUser1Password  |
      | TestUser2   | TestUser2Password  |
      | TestUser3   | TestUser3Password  |
      | TestUser4   | TestUser4Password  |

  Scenario: Reset user generator counter
    When user counter generator is reset
    Then file contents are "0"
