class RootController < ApplicationController

  # GET /
  def index
    @next_event = Event.future.first :order => 'date_and_time ASC'
    
    @random_people = Person.all(:limit => 10, :order => 'random()')
  end
end
