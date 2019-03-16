Feature: Create a private project

  In order to limit the number of people who have access to a given project<br/>
  As a user<br/>
  I should be able to create a private project

  Scenario: Creating a new project, setting it to private, trying to access project without permission
    Given I am logged in as "UserWhichExists" with password "Password"
    When I create a private project
    Then people who don't have access to my project won't be able to see it
