module Support

  # Transform string, downcase all words, capitalize each not on list, capitalize first word. 
  def titleize(string)
    words_not_to_capitalize = ["the","a","an","and","but","for","of","to","at","by","from"]
    s = string.split.each{|word| word.capitalize! unless words_not_to_capitalize.include? (word.downcase) }
    s[0].capitalize + " " + s[1..-1].join(" ")
  end

  # Return count and word properly pluralized.
  def pluralize(count, singular, plural)
    if count == 1
      count.to_s + " " + singular
    else
      count.to_s + " " + plural
    end
  end

  # Colorize UNIX output - blue
  def blue(string) 
    "\e[34m#{string}\e[0m"
  end
end

class String
  # colorize UNIX output cyan 
  def cyan
    "\e[36m#{self}\e[0m" 
  end

  # colorize UNIX output blue
  def blue
    "\e[34m#{self}\e[0m" 
  end 

  # bold UNIX output
  def bold
    "\e[1m#{self}\e[22m" 
  end 
end