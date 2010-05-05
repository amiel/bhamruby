class Project < ActiveRecord::Base
  belongs_to :maintainer, :class_name => "Person", :foreign_key => "maintainer_id"
  has_and_belongs_to_many :people
  has_and_belongs_to_many :companies
  include SerializedAttributes.new(:links, *configatron.link_types)

end
