require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    js_errors:         false,
    phantomjs_options: [
      '--ignore-ssl-errors=yes',
      '--disk-cache=yes',
      '--max-disk-cache-size=10000'
    ],
    phantomjs_logger: false,
    logger:           false
  })
end
Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 15


RSpec.configure do |config|
  config.after(:each) do
    if example.exception && example.metadata[:js]
      spec_filename = File.basename(example.metadata[:file_path])
      line_number   = example.metadata[:line_number]
      filename      = Rails.root.join(
        'tmp',
        'capybara',
        "#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')} #{spec_filename} failed at line #{line_number}.png"
      )
      page.save_screenshot(filename)
      puts example.metadata[:full_description] + "\n  Screenshot: #{filename}"
    end
  end
end
