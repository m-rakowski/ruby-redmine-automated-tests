Feature: Create an issue and log time

  In order to let other project members know how much time I spent on a given issue<br/>
  As a user<br/>
  I should be able to create issues and log time

  Scenario: Creating and issue and logging time
    Given I am logged in as "UserWhichExists" with password "Password"
    And project exists
    And issue exists
    When I log 1 hours of time under issue
    Then time is logged