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
  Watir.default_timeout = 6


  browser_type = ENV['BROWSER_TYPE']
  browser_type = 'chrome' if browser_type.nil?

  @browser = Watir::Browser.new browser_type.to_sym

  @browser.window.maximize
end

After do |scenario|

  # if scenario.failed?
  # end

  if @browser.exists?
    screenshot = "allure-results\\" + DateTime.now.strftime('%Q').to_s + '.png'
    @browser.screenshot.save (screenshot)
    attach_file(screenshot, File.open(screenshot))

    @browser.close
  end

end

# AfterStep do |scenario|
#   screenshot = "allure-results\\" + DateTime.now.strftime('%Q').to_s + '.png'
#   @browser.screenshot.save (screenshot)
#   attach_file(screenshot, File.open(screenshot))
# end
