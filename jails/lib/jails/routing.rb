class Routing

  # Set request object as an attribute. Declare a routes attribute. Call the draw method to populate it with a hash of routes.
  def initialize(request)
    @request = request
    @routes = {} 
    draw(Application.routes)
  end

  # Build the @routes hash by evaluating the block passed in as a proc object from the Application.routes method.
  def draw(block)   
    instance_eval(&block)
  end

  # Add route to @routes hash with the url's path as the key and target as the value.
  def match(path, target)
    @routes["#{path}"] = target
  end

  # Match request path to @routes hash. If match, create controller object and call the action.
  def dispatch
    path = @request.path
    id = nil
    segments = path.split("/").reject { |segment| segment.empty? }
    if segments[1] =~ /^\d+$/
      id = segments[1]
      segments[1] = ":id"
      path = "/#{segments.join('/')}"
    end
    if @routes.key?(path)
      target = @routes[path]
      resource_name, action_name = target.split('#')
      @request.params.merge!(resource: resource_name, action: action_name, id: id)
      klass = Object.const_get("#{resource_name.capitalize}Controller")
      puts("Processing by #{klass}##{action_name}")
      klass.new(@request).send(action_name)
    else
      Rack::Response.new(["Nothing found"], 404, {"Content-Type" => "text/html"})
    end
  rescue Exception => error
    Rack::Response.new(["Internal error"], 500, {"Content-Type" => "text/html"})
  end
end