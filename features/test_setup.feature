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