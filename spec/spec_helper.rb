ENV['RACK_ENV'] = 'test'

require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM volunteers *;')
    DB.exec('DELETE FROM projects *;')
  end
end
