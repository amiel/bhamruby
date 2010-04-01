# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Person.create(:name=>'James Mason', :email=>'james@bear454.com', :password=>'working', :password_confirmation=>'working')
Event.create(:name=>'#bhamruby Meetup', :date_and_time=>'2010-04-01 17:30 PDT', :location_title=>'Carnes Media', :location_address=>"1031 N State St.\nBellingham, WA 98225")
