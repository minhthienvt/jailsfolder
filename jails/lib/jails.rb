require('jails/version.rb')
require('jails/support.rb')
require('jails/routing.rb')
require('jails/controller.rb')
require('jails/hacktive_record.rb')

module Jails
  class Application
    # Instantiate a Request object, instantiate Routing object and call dispatch method, ultimately return response.
    def call(env)
      request = Rack::Request.new(env)
      puts("\n\nStarted #{request.request_method} \"#{request.path}\" for #{request.ip} #{Time.now}")
      response = Routing.new(request).dispatch
      return response
    end
  end
end