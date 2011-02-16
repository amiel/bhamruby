class PeopleController < ApplicationController
  before_filter :require_session, :only => [:edit, :update, :destroy]
  before_filter :require_no_session, :only => [:new, :create]
  before_filter :am_i_current_person, :only => [:edit, :update, :destroy]
  
  # GET /people
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
      format.json { render :json => @people }
    end
  end

  # GET /people/1
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @person }
      format.json { render :json => @person }
    end
  end

  # GET /people/new
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
      format.json { render :json => @person }
    end
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        flash[:success] = 'Person was successfully created.'
        format.html { redirect_to(@person) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
        format.json { render :json => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
        format.json { render :json => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  def update
    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:success] = 'Person was successfully updated.'
        format.html { redirect_to(@person) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
        format.json { render :json => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  protected
  
  def am_i_current_person
    @person = Person.find(params[:id])
    unless current_person == @person || current_person.admin?
      flash[:error] = "You can only do that to your own data."
      redirect_to :back 
    end
  end
end
