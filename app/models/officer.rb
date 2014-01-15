class Officer < User
  def guest?
    false
  end

  def member?
    true
  end

  def officer?
    true
  end
end

