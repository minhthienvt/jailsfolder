module Support
  # Transform string, downcase all words, capitalize each not on list, capitalize first word. 
  def titleize(string)
    words_not_to_capitalize = ["the","a","an","and","but","for","of","to","at","by","from"]
    s = string.split.each{|word| word.capitalize! unless words_not_to_capitalize.include? (word.downcase) }
    s[0].capitalize + " " + s[1..-1].join(" ")
  end
end
