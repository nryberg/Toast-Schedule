class Relationship
  include MongoMapper::Document

  key :type, String
  key :club, ObjectId
  key :member, ObjectId
  # Can be 
  #   Guest
  #   Visitor
  #   Member
  #   Officer
  #   Alumni
  #   Administrator
  
  def club_name
#    Club.find(self.club).name
  end
    
  def member_name
    Member.find(self.member).name
  end

  def is_admin
    self.type == "Administrator"
  end
end
