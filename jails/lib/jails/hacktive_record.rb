require "sqlite3"

# Simplistic ORM library using the Active Record pattern
module HacktiveRecord
  class Base
    DB = SQLite3::Database.new("db/development.sqlite3")

    # Return table name string by transforming the model class's name to lower case plural.
    def self.table
      table_name = self.name.downcase + "s"
      return table_name
    end

    # Return array of DB column names converted to symbols.
    def self.columns
      columns = DB.table_info(table).map { |info| info["name"].to_sym }
      return columns
    end

    # Return number of rows by executing a count query on the database for the resource.
    def self.count
      rows_count = DB.execute("SELECT COUNT(*) FROM #{table}")[0][0]
      return rows_count
    end

    # Return array of all rows in queried from the database table, converted to objects of the resource.
    def self.all
      rows = DB.execute("SELECT * FROM #{table}")
      objects = rows.map do |row|
        attributes = Hash[columns.zip(row)]
        self.new(attributes)
      end
      return objects
    end

    # Return an object by querying the database for the requested row searching by id.
    def self.find(id)
      row = DB.execute("SELECT * FROM #{table} WHERE id = ? LIMIT 1", id).first 
      attributes = Hash[columns.zip(row)]
      object = self.new(attributes)
      return object
    end

    # Save object as a new row to the database table, returning the object with the new attribute's id value.
    def save
      new_object = self
      columns = new_object.class.columns
      columns.delete(:id)
      placeholders = (["?"] * (columns.size)).join(",") 
      values = columns.map { |key| self.send(key) } 
      columns = columns.join(",") 
      DB.execute("INSERT INTO #{self.class.table} (#{columns}) VALUES (#{placeholders})", values)
      new_object.id = DB.execute("SELECT last_insert_rowid()")[0][0]
      return new_object
    end

    # Modify row in database.
    def update(attributes={})
      columns = attributes.keys
      columns = columns.map { |column| "#{column}=?" }.join(",")
      values = attributes.values
      values << id
      DB.execute("UPDATE #{self.class.table} SET #{columns} WHERE id = ?", values)
    end

    # Delete row from database.
    def destroy
      DB.execute("DELETE FROM #{self.class.table} WHERE id = ?", id)
    end
  end
end