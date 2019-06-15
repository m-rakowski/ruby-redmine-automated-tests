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
    When creating a private project with name "project_to_be_closed" if it does not exist yet
    And reopening the project if closed
    Then logout

  Scenario: Creating a project and closing it right away (to be reopened later on)
    Given I am logged in as "UserWhichExists" with password "Password"
    When creating a private project with name "project_to_be_reopened" if it does not exist yet
    And closing the project if open
    Then logout

  Scenario: Deleting the "PrivateProjectTest" project
    Given I am logged in as "admin" with password "Password"
    When I delete the private project if it exists
    Then it is no longer displayed on the list of projects

  Scenario: Deleting a file from wiki
    Given I am logged in as "admin" with password "Password"
    And private project wiki page is open
    When I try to delete all files
    Then there are no files on the wiki page
