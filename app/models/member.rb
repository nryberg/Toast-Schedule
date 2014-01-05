class Member < User
  def guest?
    false
  end

  def member?
    true
  end

  def officer?
    false
  end


   
end                                                 
