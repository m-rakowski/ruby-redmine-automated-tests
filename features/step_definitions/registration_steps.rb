include AllureCucumber::DSL

Given(/^signup page open$/) do
  @browser.goto 'http://127.0.0.1:80/account/register'
  expect(@browser.text).to include 'Register'
end

Given(/^a new user$/) do
  @number = Time.now.to_i.to_s
  @username = 'TestUser' + @number
  @password = 'TestUser' + @number + 'Password'
  @firstname = 'TestUser' + @number + 'FirstName'
  @lastname = 'TestUser' + @number + 'LastName'
  @email = 'testuser' + @number + '@test.org'
end

When(/^user is being registered$/) do
  @browser.text_field(id: 'user_login').set @username
  @browser.text_field(id: 'user_password').set @password
  @browser.text_field(id: 'user_password_confirmation').set @password
  @browser.text_field(id: 'user_firstname').set @firstname
  @browser.text_field(id: 'user_lastname').set @lastname
  @browser.text_field(id: 'user_mail').set @email

  @browser.button(name: 'commit').click
end

Then(/^user registered successfully$/) do
  expect(@browser.text).to include 'Your account has been activated. You can now log in.'
  expect(@browser.text).to include 'Logged in as ' + @username

  # open('counter.txt', 'w') {|f| f << (@number.to_i + 1).to_s}
end

Given(/^a user which already exists$/) do
  @username = 'UserWhichExists'
  @password = 'Password'
  @firstname = @username + "FirstName"
  @lastname = @username + "LastName"
  @email = 'testuser' + @username + '@test.org'
end

Then(/^user will not be registered$/) do
  expect(@browser.element(id: "errorExplanation")).to be_visible
end

Given(/^a new user "([^"]*)" with password "([^"]*)"$/) do |username, password|
  @username = username
  @password = password
  @firstname = username + "FirstName"
  @lastname = username + "LastName"
  @email = 'testuser' + username + '@test.org'
end

Then(/^logout$/) do
  @browser.close
end