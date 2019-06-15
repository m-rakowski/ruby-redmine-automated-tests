@wiki
Feature: Update project wiki (file upload)

  Scenario: Upload file
    Given logged in as "admin" with password "Password"
    And edit wiki page is open
    When I try to upload a file
    Then the file gets updated