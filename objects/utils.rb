class Utils

  def self.waitAndRefreshUntilPresent(iterationsTimeOut, element, browser)

    x = 0
    while true do

      begin
        sleep 0.2
        browser.refresh
      end if !element.exists?


      x += 1
      break if x > iterationsTimeOut
    end

  end

end
