require 'date'

include AllureCucumber::DSL


Given('I am logged in as "{word}" with password "{word}"') do |username, password|
  @time = Time.now.to_i.to_s

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/login'
  @browser.text_field(id: 'username').send_keys username
  @browser.text_field(id: 'password').send_keys password
  @browser.button(name: 'login').click

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include username
end

When("I create a private project") do

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/new'
  @browser.text_field(id: 'project_name').send_keys("PrivateProjectTest")
  @browser.textarea(id: 'project_description').send_keys("description " + @time)
  @browser.text_field(id: 'project_identifier').clear
  @browser.text_field(id: 'project_identifier').send_keys("id_" + @time)

  @browser.checkbox(:id => 'project_is_public').uncheck

  @browser.button(name: 'commit').click

  @browser.a(class: 'logout').click
end


When("I create a private project with name \"{word}\"") do |projectName|

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/new'
  @browser.text_field(id: 'project_name').send_keys(projectName)
  @browser.textarea(id: 'project_description').send_keys(projectName)
  @browser.text_field(id: 'project_identifier').clear
  @browser.text_field(id: 'project_identifier').send_keys("id_" + projectName)

  @browser.checkbox(:id => 'project_is_public').uncheck

  @browser.button(name: 'commit').click

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.a(class: 'logout').click
end


Then("people who don't have access to my project won't be able to see it") do

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/login'
  @browser.text_field(id: 'username').send_keys 'OtherUser'
  @browser.text_field(id: 'password').send_keys 'Password'
  @browser.button(name: 'login').click

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'OtherUser'

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/' + 'id_' + @time
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.element(id: 'errorExplanation').text).to include 'You are not authorized to access this page.'

end


When("I delete the private project if it exists") do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/admin/projects'
  @browser.text_field(id: 'name').send_keys("PrivateProjectTest")
  @browser.input(type: 'submit').click

  unless @browser.p(class: 'nodata').exist?
    @browser.element(xpath: "//a[text()[contains(., '" + "PrivateProjectTest" + "')]]/../../..//a[contains(@class, 'icon-del')]").click
    @browser.checkbox(:id => 'confirm').check
    @browser.element(name: "commit").click
  end

end

When("I delete the private project") do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/admin/projects'
  @browser.text_field(id: 'name').send_keys("PrivateProjectTest")
  @browser.input(type: 'submit').click

  @browser.element(xpath: "//a[text()[contains(., '" + "PrivateProjectTest" + "')]]/../../..//a[contains(@class, 'icon-del')]").click
  @browser.checkbox(:id => 'confirm').check
  @browser.element(name: "commit").click

end


Then("it is no longer displayed on the list of projects") do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/admin/projects'
  @browser.text_field(id: 'name').send_keys("PrivateProjectTest")
  @browser.input(type: 'submit').click

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.p(class: 'nodata').text).to include 'No data to display'
end



