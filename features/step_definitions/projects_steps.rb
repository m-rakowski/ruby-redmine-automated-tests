include AllureCucumber::DSL

And(/^a project which does not yet exist$/) do
  @project_name = 'project' + DateTime.now.strftime('%Q').to_s
  @project_description = 'description ' + DateTime.now.strftime('%Q').to_s
  @project_identifier = 'projectid' + DateTime.now.strftime('%Q').to_s
end

When(/^user tries to create the project$/) do

  @browser.goto 'http://127.0.0.1:80/projects/new'

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
  @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier;

  @browser.a(class: 'icon-lock').click

  Watir::Wait.until {@browser.alert.exists?}
  @browser.alert.ok

  @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier;
  expect(@browser.a(class: 'icon-unlock')).to be_visible
end

When(/^closing the project if open$/) do
  @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier;

  if (@browser.a(class: 'icon-lock').exists?)
    @browser.a(class: 'icon-lock').click

    Watir::Wait.until {@browser.alert.exists?}
    @browser.alert.ok

    @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier;
    expect(@browser.a(class: 'icon-unlock')).to be_visible
  end
end

Then(/^the project becomes read-only$/) do
  @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier + '/issues/new'
  expect(@browser.element(id: "errorExplanation").text).to include 'You are not authorized to access this page.'
end

When(/^reopens the project$/) do
  @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier

  @browser.a(class: 'icon-unlock').click

  Watir::Wait.until {@browser.alert.exists?}
  @browser.alert.ok

  @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier;
  expect(@browser.a(class: 'icon-lock')).to be_visible
end


When(/^reopening the project if closed$/) do
  @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier

  if (@browser.a(class: 'icon-unlock').exists?)
    @browser.a(class: 'icon-unlock').click

    Watir::Wait.until {@browser.alert.exists?}
    @browser.alert.ok

    @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier;
    expect(@browser.a(class: 'icon-lock')).to be_visible
  end
end

Then(/^new issues can be added to the project$/) do
  @browser.goto 'http://127.0.0.1:80/projects/' + @project_identifier + '/issues/new'
  expect(@browser.element(id: "errorExplanation")).not_to be_present
end

When(/^creating a private project with name "([^"]*)" if it does not exist yet$/) do |projectName|

  @project_identifier = "id_" + projectName

  @browser.goto 'http://127.0.0.1:80/projects/new'
  @browser.text_field(id: 'project_name').set(projectName)
  @browser.textarea(id: 'project_description').set(projectName)
  @browser.text_field(id: 'project_identifier').set("id_" + projectName)

  @browser.checkbox(:id => 'project_is_public').uncheck

  @browser.button(name: 'commit').click

end