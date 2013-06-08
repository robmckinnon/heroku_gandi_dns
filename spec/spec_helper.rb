require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'minitest/autorun'
require 'mocha/setup'
begin
  require 'turn/autorun'
  Turn.config.format = :dot
rescue LoadError
end

