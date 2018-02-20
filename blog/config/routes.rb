class Application                                                                                                            
  def self.routes                                                                                                       
    Proc.new do                                                                                                         
      match("/", "pages#home")
      match("/about", "pages#about")
      match("/user", "pages#user")
      match("/pages/:id", "pages#show")
      match("/jogin", "pages#jogin")
      match("/jogout", "pages#jogout")

      match("/articles", "articles#index")
      match("/articles/new", "articles#new")
      match("/articles/create", "articles#create")
      match("/articles/:id", "articles#show")
      match("/articles/:id/edit", "articles#edit")
      match("/articles/:id/update", "articles#update")
      match("/articles/:id/destroy", "articles#destroy")
    end                                                                                                                 
  end                                                                                                                   
end