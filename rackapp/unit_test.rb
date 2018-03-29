require "rack"
require "minitest/autorun"
require File.join(__dir__, "config/application.rb")

class TestApplication < Minitest::Test
  def setup
    @request = Rack::MockRequest.new(Application.new)
  end
  
  def test_that_valid_path_returns_200
    assert_equal(200, @request.get("/").status)
  end

  def test_that_home_displays_cookie
    assert_match(/cookie: name=/i, @request.get("/").body)
  end

  def test_that_home_displays_link
    assert_includes(@request.get("/").body, "<a href='/redirect-me'>Redirect to build-response</a>")
  end

  def test_that_home_displays_cookie_value
    refute_match(/Cookie: name=Joey/, @request.get("/").body)
    assert_includes(@request.get("/", "HTTP_COOKIE" => "name=DeeDee").body, "Cookie: name=DeeDee")
  end  

  def test_that_setcookie_sets_cookie_and_redirects_to_root
    response = @request.post("/set-cookie", "HTTP_REFERER" => "/", params: {"name" => "Joey"}) 
    assert_equal(302, response.status)
    assert_equal("/", response["Location"])
    assert_includes(response["Set-Cookie"], "name=Joey")
  end

  def test_that_deletecookie_deletes_cookie_and_redirects_to_root
    response = @request.get("/delete-cookie", "HTTP_COOKIE" => "name=Joey", "HTTP_REFERER" => "/")
    assert_equal(302, response.status)
    assert_equal("/", response["Location"])
    assert_includes(response["Set-Cookie"], "name=")
  end

  def test_that_redirect_redirects_to_buildresponse
    response = @request.get("/redirect-me")
    assert_equal(302, response.status)
    assert_equal("/build-response", response["Location"])
  end

  def test_that_buildresponse_returns_expected_response
    response = @request.get("/build-response")
    assert_match(/home/i, response.body)  
    assert_equal(200, response.status)
    assert_equal("text/html", response["Content-Type"])
    assert_equal("Some info", response["Custom-Header"])
    assert_includes(response["Set-Cookie"], "name=Sheena")
  end

  def test_that_bad_path_returns_404
    assert_equal(404, @request.get("/badpath").status)
  end

  def test_that_will_be_skipped
    skip "test this later"
  end
end