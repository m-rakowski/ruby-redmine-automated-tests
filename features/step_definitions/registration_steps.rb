include AllureCucumber::DSL

Given(/^signup page open$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/account/register'
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'Register'
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
  @browser.text_field(id: 'user_login').send_keys @username
  @browser.text_field(id: 'user_password').send_keys @password
  @browser.text_field(id: 'user_password_confirmation').send_keys @password
  @browser.text_field(id: 'user_firstname').send_keys @firstname
  @browser.text_field(id: 'user_lastname').send_keys @lastname
  @browser.text_field(id: 'user_mail').send_keys @email

  @browser.button(name: 'commit').click
end

Then(/^user registered successfully$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'Your account has been activated. You can now log in.'
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'Logged in as ' + @username

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
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.div(id: "errorExplanation")).to be_visible
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