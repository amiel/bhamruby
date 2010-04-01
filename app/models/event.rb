class Event < ActiveRecord::Base
  belongs_to :coordinator, :class_name => "Person", :foreign_key => "coordinator_id"
  has_many :attendances
  has_many :attending_people, :class_name => "Person", :through => :attendances, 
    :conditions => {:attending=>'yes'}
  has_many :declining_people, :class_name => "Person", :through => :attendances,
    :conditions => {:attending=>'no'}
  has_many :uncommitted_people, :class_name => "Person", :through => :attendances,
    :conditions => 'attending NOT IN (\'yes\',\'no\')'
  
end
