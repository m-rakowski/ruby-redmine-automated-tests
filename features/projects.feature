@projects
Feature: Projects

  Scenario: Creating a new project
    Given logged in as "UserWhichExists" with password "Password"
    And a project which does not yet exist
    When user tries to create the project
    Then project gets created successfully

  Scenario: Closing a project (making it read-only)
    Given logged in as "UserWhichExists" with password "Password"
    And a project with id id_project_to_be_closed which exists
    When closing the project
    Then the project becomes read-only

  Scenario: Reopening a project
    Given logged in as "UserWhichExists" with password "Password"
    And a project with id id_project_to_be_reopened which exists
    When reopens the project
    Then new issues can be added to the project