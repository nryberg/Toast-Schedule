class Relationship
  include MongoMapper::Document

  scope :by_club, lambda { |club_id| where(:club => club_id)}
  scope :by_member, lambda { |member_id| where(:member => member_id)}
  scope :members, where(:type => "Member")
  scope :guests, where(:type => "Guest")
  scope :officers, where(:type => "Officer")
  scope :administrators, where(:type => "Administrator")
  scope :visitors, where(:type => "Visitor")

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
    Club.find(self.club).name
  end
  
  def club_object
    Club.find(self.club)
  end
    
  def member_object
    Member.find(self.member)
  end

  def is_admin
    self.type == "Administrator"
  end
end
