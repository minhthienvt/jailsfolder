class Article < HacktiveRecord::Base

  # Getter and Setter methods for listed attributes.
  attr_accessor(:id, :title, :content, :created_at)

  # Set attributes when a new article object is instantiated.
  def initialize(id: nil, title: nil, content: nil, created_at: timestamp)
    @id = id
    @title = title
    @content = content
    @created_at = created_at
  end

  # Return current date and time as a string.
  def timestamp
    Time.now.to_s
  end

  # Return a date object by parsing the created_at date-time string. 
  def created_at
    DateTime.parse(@created_at)
  end
  
  # Return title when accessing object as string, overrides default: class, encoded object id and instance variables.
  def to_s
    title
  end
end