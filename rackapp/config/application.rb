class Application
  # Instantiate a Request object, return Response object depending on URL path.
  def call(env)
    request = Rack::Request.new(env)
    case request.path_info
    when "/"
      Rack::Response.new(["<p>Cookie: name=#{request.cookies["name"]}</p>",
          "<p><a href='/delete-cookie'>Delete-Cookie</a></p>",
          %q(<form method="post" action="/set-cookie">
              <input name="name" type="text" placeholder="Enter Name">
              <input type="submit" value="Set-Cookie">
            </form>),
          "<a href='/redirect-me'>Redirect to build-response</a> | <a href='/nowhere'>bad link</a>"], 
        200, {"Content-Type" => "text/html"})
    when "/set-cookie"
      Rack::Response.new do |response|
        response.set_cookie("name", request.params["name"])
        response.redirect(request.referer)
      end 
    when "/delete-cookie"  
      Rack::Response.new do |response|
        response.delete_cookie("name")
        response.redirect(request.referer)
      end
    when "/redirect-me"
      Rack::Response.new([], 302, {"Location" => "/build-response"})
    when "/build-response"
      response = Rack::Response.new
      response.write("<a href='/'>Home</a>")
      response.status = 200
      response.set_header("Content-Type", "text/html")
      response['Custom-Header'] = 'Some info'
      response.set_cookie("name", {value: "Sheena", path: "/", expires: Time.now + (60*60*24*365*20)})
      response.finish
    else
      Rack::Response.new(["Nothing Found"], 404, {"Content-Type" => "text/html"})
    end
  end
end