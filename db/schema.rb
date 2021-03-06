# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110216195702) do

  create_table "attendances", :force => true do |t|
    t.integer "person_id"
    t.integer "event_id"
    t.string  "attending"
  end

  create_table "companies", :force => true do |t|
    t.string    "name"
    t.string    "url"
    t.text      "address"
    t.string    "phone"
    t.text      "links"
    t.integer   "owner_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "logo_file_name"
    t.string    "logo_content_type"
    t.integer   "logo_file_size"
    t.timestamp "logo_updated_at"
  end

  create_table "companies_projects", :force => true do |t|
    t.integer "company_id"
    t.integer "project_id"
  end

  create_table "events", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.timestamp "date_and_time"
    t.string    "location_title"
    t.text      "location_address"
    t.integer   "coordinator_id"
    t.text      "links"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "byob"
  end

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.text     "posting"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.boolean  "approved",      :default => false
    t.integer  "person_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.string    "phone"
    t.string    "email",                                  :null => false
    t.text      "links"
    t.integer   "company_id"
    t.string    "crypted_password",                       :null => false
    t.string    "password_salt",                          :null => false
    t.string    "persistence_token",                      :null => false
    t.string    "single_access_token",                    :null => false
    t.string    "perishable_token",                       :null => false
    t.integer   "login_count",         :default => 0,     :null => false
    t.integer   "failed_login_count",  :default => 0,     :null => false
    t.timestamp "last_request_at"
    t.timestamp "current_login_at"
    t.timestamp "last_login_at"
    t.string    "current_login_ip"
    t.string    "last_login_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "admin",               :default => false
  end

  create_table "people_projects", :force => true do |t|
    t.integer "person_id"
    t.integer "project_id"
  end

  create_table "projects", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.string    "url"
    t.text      "links"
    t.integer   "maintainer_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
