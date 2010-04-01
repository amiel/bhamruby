class Basis < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.text :description
      t.string :phone
      t.string :email,               :null => false
      t.text :links
      t.belongs_to :company

      # authlogic
      t.string    :crypted_password,    :null => false
      t.string    :password_salt,       :null => false
      t.string    :persistence_token,   :null => false
      t.string    :single_access_token, :null => false
      t.string    :perishable_token,    :null => false
      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at 
      t.datetime  :last_login_at
      t.string    :current_login_ip 
      t.string    :last_login_ip

      t.timestamps
    end

    create_table :companies do |t|
      t.string :name
      t.string :url
      t.string :address
      t.string :phone
      t.text :links
      t.belongs_to :owner

      t.timestamps
    end

    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :url
      t.text :links
      t.belongs_to :maintainer

      t.timestamps
    end

    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :at
      t.string :location
      t.belongs_to :coordinator

      t.timestamps
    end
    
    create_table :people_projects do |t|
      t.belongs_to :person
      t.belongs_to :project
    end
    
    create_table :companies_projects do |t|
      t.belongs_to :company
      t.belongs_to :project
    end
    
    create_table :attendances do |t|
      t.belongs_to :person
      t.belongs_to :event
      t.string :attending
    end
  end

  def self.down
    drop_table :people
    drop_table :companies
    drop_table :projects
    drop_table :events
    drop_table :people_projects
    drop_table :companies_projects
  end
end
