Feature: Registration

  In order to have an account in Redmine
  As a user
  I should be able to register an account

  Background:
    Given signup page open

  Scenario: Registering a new user
    Given a new user
    When user is being registered
    Then user registered successfully

  Scenario: Trying to register a user which already exists
    Given a user which already exists
    When user is being registered
    Then user will not be registered