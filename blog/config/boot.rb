require_relative('routes.rb')
require('jails')
Dir[File.join(__dir__, '..', 'app', 'controllers', '*.rb')].each {|file| require(file) }
Dir[File.join(__dir__, '..', 'app', 'models', '*.rb')].each {|file| require(file) }