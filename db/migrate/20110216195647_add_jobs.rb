class AddJobs < ActiveRecord::Migration
  def self.up
    
    create_table :jobs do |t|
      t.string :title
      t.text :posting
      t.string :contact_email
      t.string :contact_phone
      
      t.boolean :approved, :default => false
      
      t.belongs_to :person
      t.belongs_to :company

      t.timestamps
    end
    
  end

  def self.down
    drop_table :jobs
  end
end
