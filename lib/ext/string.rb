class String
  def green
    "\e[32m#{self}\e[0m"
  end
  
  def red
    "\e[31m#{self}\e[0m"
  end
  
  def magenta
    "\e[35m#{self}\e[0m"
  end
end