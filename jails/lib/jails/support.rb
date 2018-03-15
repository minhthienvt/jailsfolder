module Support

  # Transform string, downcase all words, capitalize each not on list, capitalize first word. 
  def titleize(string)
    do_not_capitalize = ["the","a","an","and","but","or","nor","for","of","to","at","by","from","in","on"] 
    array = string.split.each do |word| 
      if do_not_capitalize.include?(word.downcase)
        word.downcase!
      else
        word.capitalize! 
      end
    end
    array[0].capitalize + " " + array[1..-1].join(" ")
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

  # colorize UNIX output green
  def green
    "\e[32m#{self}\e[0m" 
  end
  
  # colorize UNIX output brown
  def brown
    "\e[33m#{self}\e[0m" 
  end
  
  # colorize UNIX output red
  def red
    "\e[31m#{self}\e[0m" 
  end

  # bold UNIX output
  def bold
    "\e[1m#{self}\e[22m" 
  end 
end