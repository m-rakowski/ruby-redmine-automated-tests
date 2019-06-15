include AllureCucumber::DSL


When(/^deleting account$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;@browser.goto 'http://localhost:10083/my/account/destroy'
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'Your account will be permanently deleted, with no way to reactivate it.'

  @browser.checkbox(:id => 'confirm').set
  @browser.button(name: 'commit').click

end

Then(/^the account is deleted$/) do
  sleep 0.5 if @browser.driver.browser.eql? :internet_explorer;expect(@browser.text).to include 'Your account has been permanently deleted.'
end

When(/^user counter generator is reset$/) do
  open('counter.txt', 'w') {|f| f << "0"}

end

Then(/^user counter file content is "(\d+)"$/) do |number|
  expect(File.read('counter.txt')).to eq number.to_s
end