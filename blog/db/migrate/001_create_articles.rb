require 'sqlite3'

# define db. If there is no db/development.sqlite3 it will be created. 
db = SQLite3::Database.new(File.join("db", "development.sqlite3"))

db.execute(<<SQL
CREATE TABLE articles (
id INTEGER PRIMARY KEY,
title VARCHAR(255),
content TEXT,
created_at DATETIME DEFAULT NULL
);
SQL
)

# To run this: $ ruby db/migrate/001_create_articles.rb
# To see if the db file is created in the db folder: $ ls db