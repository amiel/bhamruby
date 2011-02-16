class Person < ActiveRecord::Base
  include Gravtastic

  belongs_to :company # we should change this to a HABTM
  has_and_belongs_to_many :projects
  has_many :attendances
  has_many :events, :through => :attendances
  acts_as_authentic
  is_gravtastic!
  
  def can_edit?(object)
    (true and return) if self.admin?

    case object
    when Person
      self == object
    when Company
      object.owner == self
    when Event
      object.coordinator == self
    when Project
      object.maintainer == self # should also walk through the project's companies
    when Job
      object.person == self
    else
      false
    end
  end
  
  
  include SerializedAttributes.new(:links, *configatron.link_types)
end
