require 'date'

include AllureCucumber::DSL


Given('I am logged in as "{word}" with password "{word}"') do |username, password|
  @time = Time.now.to_i.to_s

  @browser.goto 'http://127.0.0.1:80/login'
  @browser.text_field(id: 'username').set username
  @browser.text_field(id: 'password').set password
  @browser.button(name: 'login').click

  expect(@browser.text).to include username
end

When("I create a private project") do

  @browser.goto 'http://127.0.0.1:80/projects/new'
  @browser.text_field(id: 'project_name').set("PrivateProject" + @time)
  @browser.textarea(id: 'project_description').set("description " + @time)
  @browser.text_field(id: 'project_identifier').set("id_" + @time)

  @browser.checkbox(:id => 'project_is_public').uncheck

  @browser.button(name: 'commit').click

  @browser.a(class: 'logout').click
end


When("I create a private project with name \"{word}\"") do |projectName|

  @browser.goto 'http://127.0.0.1:80/projects/new'
  @browser.text_field(id: 'project_name').set(projectName)
  @browser.textarea(id: 'project_description').set(projectName)
  @browser.text_field(id: 'project_identifier').set("id_" + projectName)

  @browser.checkbox(:id => 'project_is_public').uncheck

  @browser.button(name: 'commit').click

  @browser.a(class: 'logout').click
end


Then("people who don't have access to my project won't be able to see it") do

  @browser.goto 'http://127.0.0.1:80/login'
  @browser.text_field(id: 'username').set 'OtherUser'
  @browser.text_field(id: 'password').set 'Password'
  @browser.button(name: 'login').click

  expect(@browser.text).to include 'OtherUser'

  @browser.goto 'http://127.0.0.1:80/projects/' + 'id_' + @time
  expect(@browser.element(id: 'errorExplanation').text).to include 'You are not authorized to access this page.'

end
