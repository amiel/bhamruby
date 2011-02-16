class EventsController < ApplicationController
  before_filter :require_session, :only => [:edit, :update, :destroy]
  before_filter :check_permissions, :only => [:edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        flash[:success] = 'Event was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
        format.json { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
     end
    end
  end

  # PUT /events/1
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:success] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end

  protected
  
  def check_permissions
    @event = Event.find(params[:id])
    unless current_person and current_person.can_edit?(@event)
      flash[:error] = "You can only do that to your own data."
      redirect_to :back 
    end
  end

end
