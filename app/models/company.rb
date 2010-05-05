class Company < ActiveRecord::Base
  has_many :people
  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"
  has_and_belongs_to_many :projects
  
  include SerializedAttributes.new(:links, *configatron.link_types)
  
  has_attached_file :logo, PaperclipOptions.new({
    :default_style => :icon,
    :styles => {
      :icon => '42x42#',
      :thumb => '64x64#',
    }
  })
  
end
