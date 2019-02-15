$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'constants'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
