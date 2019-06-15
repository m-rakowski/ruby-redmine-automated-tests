@private_project
Feature: Create and deleting private projects

  Scenario: Creating a new project, setting it to private, trying to access project without permission
    Given I am logged in as "UserWhichExists" with password "Password"
    When I create a private project
    Then people who don't have access to my project won't be able to see it

  Scenario: Deleting a project as admin
    Given I am logged in as "admin" with password "Password"
    When I delete the private project
    Then it is no longer displayed on the list of projects

