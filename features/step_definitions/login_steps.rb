require 'date'

include AllureCucumber::DSL

Given("login page open") do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/login'
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'Login'
end

Given(/^logged in as "([^"]*)" with password "([^"]*)"$/) do |username, password|


  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/login'

  @browser.text_field(id: 'username').send_keys username
  @browser.text_field(id: 'password').send_keys password

  @browser.button(name: 'login').click
end

Given("a user which exists") do
  @username = 'UserWhichExists'
  @password = 'Password'
end

Given("a user which does not exist") do
  @username = '9hf983jh93hrhsdhoha'
  @password = 'h89yhsjkf32hihjkhdf'
end

When("user logs in") do
  @browser.text_field(id: 'username').send_keys @username
  @browser.text_field(id: 'password').send_keys @password

  @browser.button(name: 'login').click
end

Then("user logged in successfully") do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'Logged in as ' + @username
end


Then("user did not log in") do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'Invalid user or password'
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).not_to include 'Logged in as '+@username
end
