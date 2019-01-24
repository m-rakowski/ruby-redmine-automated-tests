require 'watir'
require 'allure-cucumber'
include AllureCucumber::DSL

class Cucumber::Core::Test::Step
  def name
    return text if self.text == 'Before hook'
    return text if self.text == 'After hook'
    "#{source.last.keyword}#{text}"
  end
end

Before do
  @browser = Watir::Browser.new :chrome
  @browser.window.maximize
end

After do |scenario|

  # if scenario.failed?
  screenshot = "allure-results\\" + DateTime.now.strftime('%Q').to_s + '.png'
  @browser.screenshot.save (screenshot)
  attach_file(screenshot, File.open(screenshot))
  # end

  @browser.close
end