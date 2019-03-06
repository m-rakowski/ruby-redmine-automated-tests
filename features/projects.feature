Feature: Projects

  Scenario: Creating a new project
    Given user logged in
    And a project which does not yet exist
    When user tries to create the project
    Then project gets created successfully

  Scenario: Closing a project (making it read-only)
    Given user logged in
    And a project which exists
    When closes the project
    Then the project becomes read-only

  Scenario: Reopening a project
    Given user logged in
    And a project which exists
    When reopens the project
    Then new issues can be added to the project
