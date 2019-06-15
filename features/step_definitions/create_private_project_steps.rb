require 'date'

include AllureCucumber::DSL


Given("project exists") do

  @existingProject = "id_myveryprivateproject"
end

Given("issue exists") do

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto "http://localhost:10083/projects/" + @existingProject + "/issues/new"
  @browser.text_field(id: 'issue_subject').send_keys('issue' + @time)
  @browser.textarea(id: 'issue_description').send_keys('description' + @time)
  @browser.button(name: 'commit').click

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.element(id: 'flash_notice').a.text).to include '#'

  @issueId = @browser.element(id: 'flash_notice').a.text.gsub('#', '')

end

When("I log {int} hours of time under issue") do |hours|

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto "http://localhost:10083/issues/" + @issueId

  @browser.a(class: 'icon-time-add').click
  @browser.text_field(id: 'time_entry_hours').send_keys(hours)

  # @browser.select_list(id: 'time_entry_activity_id').option(index: 0).click
  # @browser.select_list(id: 'time_entry_activity_id').select('time tracker')

  @browser.button(name: 'commit').click

end

Then("time is logged") do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto "http://localhost:10083/issues/" + @issueId

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.element(css: 'div.spent-time.attribute div.value').text).to include '1.00 h'
end