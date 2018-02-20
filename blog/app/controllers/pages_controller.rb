class PagesController < Controller
  # GET /
  def home
    render
  end

  # GET /about
  def about
    @title = "about"
    render
  end

  # GET /pages/302
  def show
    redirect_to("/")
  end

  # GET /user
  def user
    @name = @request.cookies["name"]
    render
  end

  # POST /jogin
  def jogin
    set_cookie("name", params["name"])
  end

  # GET /jogout
  def jogout
    delete_cookie("name")
  end
end