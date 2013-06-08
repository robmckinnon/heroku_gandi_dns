require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'mocha/setup'
begin
  require 'turn/autorun'
  Turn.config.format = :dot
rescue LoadError
end

