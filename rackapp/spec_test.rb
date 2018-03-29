require "rack"
require "minitest/autorun"
require File.join(__dir__, "config/application.rb")

describe Application do
  before do
    @request = Rack::MockRequest.new(Application.new)
  end

  # Multiple tests for one resource
  it "returns a 200 response for valid path / request" do
    @request.get("/").status.must_equal(200)
  end

  it "/ displays text" do
    @request.get("/").body.must_match(/Cookie: name=/)
  end

  it "/ includes to build-response link" do
    @request.get("/").body.must_include("Redirect to build-response")
  end

  it "/ displays cookie value when added" do
    @request.get("/").body.wont_match(/Cookie: name=Joey/)
    @request.get("/", "HTTP_COOKIE" => "name=Johnny").body.must_include("Cookie: name=Johnny")
  end

  it "/set-cookie sets cookie and redirects to root" do
    response = @request.post("/set-cookie", "HTTP_REFERER" => "/", params: {"name" => "Joey"}) 
    response.status.must_equal(302)
    response["Location"].must_equal("/")
    response["Set-Cookie"].must_include("name=Joey")
  end

  it "/delete-cookie deletes cookie and redirects to root" do
    response = @request.get("/delete-cookie", "HTTP_COOKIE" => "name=Joey", "HTTP_REFERER" => "/")
    response.status.must_equal(302)
    response["Location"].must_equal("/")
    # puts "Cookie after delete: " + response["Set-Cookie"]
    response["Set-Cookie"].must_include("name=")
  end

  it "/redirect redirects to /build-response" do
    response = @request.get("/redirect-me")
    response.status.must_equal(302)
    response["Location"].must_equal("/build-response")
  end

  it "/build-response returns expected response" do
    response = @request.get("/build-response")
    response.body.must_match(/Home/)    
    response.status.must_equal(200)
    response["Content-Type"].must_equal("text/html")
    response["Custom-Header"].must_equal("Some info")
    response["Set-Cookie"].must_include("name=Sheena")
  end

  it "returns a 404 response for bad path requests" do
    @request.get("/badpath").status.must_equal(404)
  end
end