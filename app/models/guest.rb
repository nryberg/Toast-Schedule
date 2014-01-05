class Guest < User
  def guest?
    true 
  end

  def member?
    false
  end

  def officer?
    false
  end

  def name
    "Guest"
  end


end
