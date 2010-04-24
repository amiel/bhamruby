class AddByobToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :byob, :boolean
  end

  def self.down
    remove_column :events, :byob
  end
end
