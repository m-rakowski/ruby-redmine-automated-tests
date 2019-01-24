Feature: Login

  In order to be able to use Redmine
  As a user
  I should be able to log in

  Background:
    Given login page open

  Scenario: Logging in as a user which exists
    Given a user which exists
    When user logs in
    Then user logged in successfully

  Scenario: Logging in with incorrect credentials
    Given incorrect user credentials
    When user logs in
    Then user did not log in

  Scenario: Purposely failing test to see if screenshot is added as attachment
    Given a user which does not exist
    When user logs in
    Then user logged in successfully
