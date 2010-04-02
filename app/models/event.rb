class Event < ActiveRecord::Base
  belongs_to :coordinator, :class_name => "Person", :foreign_key => "coordinator_id"
  has_many :attendances
  has_many :people, :through => :attendances
  
  named_scope :attending, :conditions => {:attending=>'yes'}
  named_scope :declining, :conditions => {:attending=>'no'}
  named_scope :uncommitted, :conditions => 'attending NOT IN (\'yes\',\'no\')'
end
