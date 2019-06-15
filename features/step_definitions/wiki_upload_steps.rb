include AllureCucumber::DSL


Given(/^private project wiki page is open$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/id_myveryprivateproject/wiki/'

end

Given(/^edit wiki page is open$/) do

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/id_myveryprivateproject/wiki/Wiki/edit'
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.h2.text).to include 'Wiki'

end

When(/^I try to upload a file$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.input(type: 'file').send_keys "C:\\Users\\Admin\\Downloads\\picture.jpg"

  @browser.element(class: 'icon-del').wait_until(&:present?)

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.input(type: 'submit').click

end

Then(/^the file gets updated$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/id_myveryprivateproject/wiki/'
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.legend.click

  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.a(class: 'icon-attachment').text).to include 'picture.jpg'

end

When(/^I try to delete all files$/) do
  @browser.legend.click
  while @browser.a(class: 'delete').exist?
    @browser.a(class: 'delete').click
    @browser.alert.ok
    @browser.legend.click
  end

end

Then(/^there are no files on the wiki page$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/projects/id_myveryprivateproject/wiki/'
  @browser.legend.click
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.legend.text).to include 'Files (0)'

end