class Person < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :projects
  has_many :attendances
  has_many :events, :through => :attendances
  acts_as_authentic
  is_gravtastic!
  
  
  include SerializedAttributes.new(:links, *configatron.link_types)
end
