class ArticlesController < Controller

  # GET /articles
  def index
    @articles = Article.all
    render
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])
    render
  end

  # GET /articles/new
  def new
    render
  end

  # POST /articles/create
  def create
    @article = Article.new(title: params['article']['title'], content: params['article']['content'])
    @article.save
    redirect_to "/articles/#{@article.id}"
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    render
  end

  # PATCH /articles/1/update
  def update
    @article = Article.find(params[:id])
    @article.update(title: params['article']['title'], content: params['article']['content'])
    redirect_to "/articles/#{@article.id}"
  end

  # GET /articles/1/destroy
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to("/articles")
  end
end