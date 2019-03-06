require 'date'

include AllureCucumber::DSL


Given("project exists") do

  @time = Time.now.to_i.to_s

  @browser.goto 'http://demo.redmine.org/projects/new'
  @browser.text_field(id: 'project_name').set("PrivateProject" + @time)
  @browser.textarea(id: 'project_description').set("description " + @time)
  @browser.text_field(id: 'project_identifier').set("id_" + @time)

  @browser.checkbox(:id => 'project_is_public').uncheck

  @browser.button(name: 'commit').click

  @existingProject = "id_" + @time
end

Given("issue exists") do

  @browser.goto "http://demo.redmine.org/projects/" + @existingProject + "/issues/new"

  expect(@browser.element(id: 'flash_notice')).to include '#{Your account has been activated. You can now log in.}'

  @browser.text_field(id: 'project_identifier').set("id_" + @time)
  @issueId = @browser.element(id: 'flash_notice').text.replace("#", "")

end

When("I log {int} hours of time under issue") do |hours|

  @browser.goto "http://demo.redmine.org/issues/" + @issueId

  @browser.a(class:'icon-time-add').click
  @browser.element(id:'time_entry_hours').set(hours)
  @browser.select_list(id:'time_entry_activity_id').select(1)
  @browser.input(name: 'commit').click

end

Then("time is logged") do
  @browser.goto "http://demo.redmine.org/issues/" + @issueId

  expect(@browser.td(class: 'spent-time')).to include '1.00 hour'
end