class RootController < ApplicationController

  # GET /
  def index
    @next_event = Event.future.first :order => 'date_and_time ASC'
  end
end
