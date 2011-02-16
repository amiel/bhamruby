class ProjectsController < ApplicationController
  before_filter :require_session, :only => [:edit, :update, :destroy]
  before_filter :check_permissions, :only => [:edit, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
      format.json { render :json => @projects }
    end
  end

  # GET /projects/1
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
      format.json { render :json => @project }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
      format.json { render :json => @project }
    end
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:success] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
        format.json { render :json => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        format.json { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:success] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        format.json { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end

  protected
  
  def check_permissions
    @project = Project.find(params[:id])
    unless current_person and current_person.can_edit?(@project)
      flash[:error] = "You can only do that to your own data."
      redirect_to :back 
    end
  end
  
end
