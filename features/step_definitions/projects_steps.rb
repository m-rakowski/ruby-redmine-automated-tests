include AllureCucumber::DSL

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

Given(/^a project with id (.*) which exists$/) do |project_id|
  @project_identifier = project_id
end

When(/^closing the project$/) do
  @browser.goto 'http://demo.redmine.org/projects/' + @project_identifier;
  @browser.a(class: 'icon-lock').click

  @browser.alert.ok
end

Then(/^the project becomes read-only$/) do
  @browser.goto 'http://demo.redmine.org/projects/' + @project_identifier + '/issues/new'
  expect(@browser.element(id: "errorExplanation").text).to include 'You are not authorized to access this page.'
end

When(/^reopens the project$/) do
  @browser.goto 'http://demo.redmine.org/projects/' + @project_identifier
  @browser.a(class: 'icon-unlock').click

  @browser.alert.ok
end

Then(/^new issues can be added to the project$/) do
  @browser.goto 'http://demo.redmine.org/projects/' + @project_identifier + '/issues/new'
  expect(@browser.element(id: "errorExplanation")).not_to be_present
end

When(/^creating a private project with name "([^"]*)" \(if it does not exists yet\)$/) do |projectName|

  @project_identifier = "id_" + projectName

  @browser.goto 'http://demo.redmine.org/projects/new'
  @browser.text_field(id: 'project_name').set(projectName)
  @browser.textarea(id: 'project_description').set(projectName)
  @browser.text_field(id: 'project_identifier').set("id_" + projectName)

  @browser.checkbox(:id => 'project_is_public').uncheck

  @browser.button(name: 'commit').click

end