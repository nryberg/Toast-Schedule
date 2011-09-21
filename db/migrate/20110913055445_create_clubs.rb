class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.text :address
      t.string :club_number
      t.timestamps
    end
  #many :members, :in => :member_ids
  #many :templates
  
  # Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  # validates_presence_of :attribute

  # Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  #many :meetings
  
  #def upcoming_meetings
  #  self.meetings.where(:meeting_date => {'$gt' => 2.day.ago.midnight}).sort(:meeting_date).all
  #end
  

  end
end
