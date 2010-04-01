class Company < ActiveRecord::Base
  has_many :people
  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"
  has_and_belongs_to_many :projects
  serialize :links
end
