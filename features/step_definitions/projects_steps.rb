require_relative '../../objects/utils'

include AllureCucumber::DSL

And(/^a project which does not yet exist$/) do
  @project_name = 'project' + DateTime.now.strftime('%Q').to_s
  @project_description = 'description ' + DateTime.now.strftime('%Q').to_s
  @project_identifier = 'projectid' + DateTime.now.strftime('%Q').to_s
end

When(/^user tries to create the project$/) do

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/new'

  @browser.text_field(id: 'project_name').send_keys @project_name
  @browser.textarea(id: 'project_description').send_keys @project_description
  @browser.text_field(id: 'project_identifier').clear
  @browser.text_field(id: 'project_identifier').send_keys @project_identifier

  @browser.button(value: 'Create').click
end

Then(/^project gets created successfully$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.div(id: "flash_notice").text).to include 'Successful creation.'
end

Given(/^a project with id (.*) which exists$/) do |project_id|
  @project_identifier = project_id
end

When(/^closing the project$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + @project_identifier;

  @browser.a(class: 'icon-lock').click

  Watir::Wait.until {@browser.alert.exists?}
  @browser.alert.ok
end

When(/^closing the project if open$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + @project_identifier;

  if (@browser.a(class: 'icon-lock').exists?)
    @browser.a(class: 'icon-lock').click

    Watir::Wait.until {@browser.alert.exists?}
    @browser.alert.ok

    sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + @project_identifier;
    sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.a(class: 'icon-unlock')).to be_visible
  end
end

Then(/^the project becomes read-only$/) do

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + @project_identifier + '/issues/new'

  Utils.waitAndRefreshUntilPresent(10, @browser.element(id: "errorExplanation"), @browser)

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.element(id: "errorExplanation").text).to include 'You are not authorized to access this page.'
end

When(/^reopens the project$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + @project_identifier

  @browser.a(class: 'icon-unlock').click

  Watir::Wait.until {@browser.alert.exists?}
  @browser.alert.ok
end


When(/^reopening the project if closed$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + @project_identifier

  if (@browser.a(class: 'icon-unlock').exists?)
    @browser.a(class: 'icon-unlock').click

    Watir::Wait.until {@browser.alert.exists?}
    @browser.alert.ok

    sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + @project_identifier;
    sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.a(class: 'icon-lock')).to be_visible
  end
end

Then(/^new issues can be added to the project$/) do

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + @project_identifier + '/issues/new'
  Utils.waitAndRefreshUntilPresent(10, @browser.element(id: "issue_subject"), @browser)

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.element(id: "errorExplanation")).not_to be_present
end

When(/^creating a private project with name "([^"]*)" if it does not exist yet$/) do |projectName|

  @project_identifier = "id_" + projectName

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/new'
  @browser.text_field(id: 'project_name').send_keys(projectName)
  @browser.textarea(id: 'project_description').send_keys(projectName)

  @browser.text_field(id: 'project_identifier').clear

  @browser.text_field(id: 'project_identifier').send_keys("id_" + projectName)

  @browser.checkbox(:id => 'project_is_public').uncheck

  @browser.button(name: 'commit').click

end