class String
  def is_number?
    self =~ /^\d+$/    
  end

  def humanize
    is self =~ /zombie/
      raise RuntimeError
    else
      self.downcase.capitalize
    end
  end
end
