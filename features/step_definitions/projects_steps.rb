Given(/^user logged in$/) do
  @username = 'TestUser1'
  @password = 'TestUser1Password'

  @browser.goto 'http://demo.redmine.org/login'
  expect(@browser.text).to include 'Login:'

  @browser.text_field(id: 'username').set @username
  @browser.text_field(id: 'password').set @password

  @browser.button(name: 'login').click

  expect(@browser.text).to include 'Logged in as ' + @username
end

And(/^a project which does not yet exist$/) do
  @project_name = 'project' + DateTime.now.strftime('%Q').to_s
  @project_description = 'description ' + DateTime.now.strftime('%Q').to_s
  @project_identifier = 'projectid' + DateTime.now.strftime('%Q').to_s
end

When(/^user tries to create the project$/) do

  @browser.goto 'http://demo.redmine.org/projects/new'

  @browser.text_field(id: 'project_name').set @project_name
  @browser.textarea(id: 'project_description').set @project_description
  @browser.text_field(id: 'project_identifier').set @project_identifier

  @browser.button(value: 'Create').click
end

Then(/^project gets created successfully$/) do
  expect(@browser.div(id: "flash_notice").text).to include 'Successful creation.'
end