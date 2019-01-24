Feature: Projects

  In order to create projects
  As a user
  I can create projects

  Scenario: Creating a new project
    Given user logged in
    And a project which does not yet exist
    When user tries to create the project
    Then project gets created successfully