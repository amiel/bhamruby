class RootController < ApplicationController

  # GET /
  def index
    @next_event = Event.find(:first, :conditions => ['date_and_time > ?', Time.current], :order => 'date_and_time ASC')
  end
end
