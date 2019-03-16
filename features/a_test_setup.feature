@test_setup
Feature: Test setup

  Scenario Outline: Looping through test user list, registering all of them if they don't exist yet
    Given signup page open
    Given a new user "<username>" with password "<password>"
    When user is being registered
    Then logout

    Examples:
      | username        | password |
      | OtherUser       | Password |
      | UserWhichExists | Password |
      | UserToBeDeleted | Password |

  Scenario: Creating a project
    Given I am logged in as "UserWhichExists" with password "Password"
    When I create a private project with name "myveryprivateproject"
    Then logout

  Scenario: Creating a project to be closed later on
    Given I am logged in as "UserWhichExists" with password "Password"
    When creating a private project with name "project_to_be_closed" (if it does not exists yet)
    And reopens the project
    Then logout

  Scenario: Creating a project and closing it right away (to be reopened later on)
    Given I am logged in as "UserWhichExists" with password "Password"
    When creating a private project with name "project_to_be_reopened" (if it does not exists yet)
    And closing the project
    Then logout