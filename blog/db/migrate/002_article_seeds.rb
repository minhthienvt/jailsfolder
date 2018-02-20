require 'sqlite3'
db = SQLite3::Database.new(File.join("db", "development.sqlite3"))
db.execute(<<SQL
INSERT INTO articles(title, content, created_at)
VALUES('Learn Rack', 'Lorem Ipsum', CURRENT_TIMESTAMP),
      ('Learn Models', 'Lorem Ipsum', CURRENT_TIMESTAMP);
SQL
)

# To run this: $ ruby db/migrate/002_article_seeds.rb