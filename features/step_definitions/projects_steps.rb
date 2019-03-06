include AllureCucumber::DSL

Given(/^user logged in$/) do
  @username = 'UserWhichExists'
  @password = 'Password'

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

Given(/^a project which exists$/) do
  @project_identifier = 'projectname4dfa3mx6t2'
end

When(/^closes the project$/) do
  @browser.goto 'http://demo.redmine.org/projects/' + @project_identifier;
  @browser.a(class: 'icon-lock').click

  @browser.alert.ok
end

Then(/^the project becomes read-only$/) do
  @browser.goto 'http://demo.redmine.org/projects/' + @project_identifier + '/issues/new'
  expect(@browser.div(id: "errorExplanation").text).to include 'You are not authorized to access this page.'
end

When(/^reopens the project$/) do
  @browser.goto 'http://demo.redmine.org/projects/' + @project_identifier;
  @browser.a(class: 'icon-unlock').click

  @browser.alert.ok
end

Then(/^new issues can be added to the project$/) do
  @browser.goto 'http://demo.redmine.org/projects/' + @project_identifier + '/issues/new'
  expect(@browser.element(id: "errorExplanation")).not_to be_present
end