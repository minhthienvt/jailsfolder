class Controller
  include Support

  # Set request object as an attribute accessible with @request variable.
  def initialize(request)
    @request = request
    puts("\s Parameters #{@request.params}")  
  end

  # helper method, params returns @request.params
  def params
    @request.params
  end

  # Return Rack response object with the erb template.
  def render
    resource = params[:resource]
    action = params[:action]
    template = "#{resource}/#{action}.html.erb"
    file = File.join('app', 'views', template)
    if File.exist?(file)
      puts("\s Rendering #{template}") # Prints in log
      render_template = ERB.new(File.read(file)).result(binding)
      puts "\s Rendered #{template}"
      response = Rack::Response.new([render_template], 200, {"Content-Type" => "text/html"})
      puts "Completed 200 OK"
      return response
    else
      puts("\s Missing Template #{template}.")
      response = Rack::Response.new(["Nothing found"], 404, {"Content-Type" => "text/html"})
      return response
    end
  end

  # Return rendered partial template to be inserted into the parent template that called it.
  def render_partial(template)
    file = File.join('app', 'views', template)
    if File.exists?(file)
      rendered_partial = ERB.new(File.read(file)).result(binding)
      puts "\s Rendered #{template}"
      return rendered_partial
    else
      puts("\s Missing Template #{template}.")
    end
  end

  # Return Rack response with header field Location assigned to path in argument.
  def redirect_to(path)
    response = Rack::Response.new([], 302, {"Location" => path})
    return response
  end

  # Set cookie with parameter key:value, then redirect back.
  def set_new_cookie(key, value)
    Rack::Response.new do |response|
      response.set_cookie(key, value)
      response.redirect(@request.referer || @request.path)
    end
  end

  # Delete cookie with parameter key and redirect back.
  def delete_the_cookie(key)
    Rack::Response.new do |response|  
      response.delete_cookie("greet")
      response.redirect(@request.referer || @request.path)
    end
  end
end