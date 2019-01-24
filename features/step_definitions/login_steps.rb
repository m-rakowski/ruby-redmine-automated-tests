require 'date'

include AllureCucumber::DSL

Given("login page open") do
  @browser.goto 'http://demo.redmine.org/login'
  expect(@browser.text).to include 'Login:'
end

Given("a user which exists") do
  @username = 'TestUser1'
  @password = 'TestUser1Password'
end

Given("a user which does not exist") do
  @username = '9hf983jh93hrhsdhoha'
  @password = 'h89yhsjkf32hihjkhdf'
end

When("user logs in") do
  @browser.text_field(id: 'username').set @username
  @browser.text_field(id: 'password').set @password

  @browser.button(name: 'login').click
end

Then("user logged in successfully") do
  expect(@browser.text).to include 'Logged in as TestUser1'
end

Given("incorrect user credentials") do
  @username = 'TestUser1'
  @password = 'TestUser1Password1'
end

Then("user did not log in") do
  expect(@browser.text).to include 'Invalid user or password'
  expect(@browser.text).not_to include 'Logged in as TestUser1'
end
