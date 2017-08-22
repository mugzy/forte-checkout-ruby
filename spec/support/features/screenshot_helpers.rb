module Features
  module ScreenshotHelpers
    def take_screenshot(affix="Manual Screenshot")
      filename = Rails.root.join(
        'tmp',
        'capybara',
        "#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')} #{affix}.png"
      )
      page.save_screenshot filename
    end
  end
end
