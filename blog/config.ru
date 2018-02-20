require_relative('config/application.rb')

# Set default Content-Type response header.
use(Rack::ContentType, "text/html")
# Automatically reload the application when a *.rb file is changed in development.
use(Rack::Reloader, 0)

# Serve static files from app/assets
use(Rack::Static, :urls => ["/stylesheets", "/javascripts", "/images"], :root => "app/assets")

# Rack method to instantiate a new Blog::Application object.
run(Blog::Application.new)