class CompaniesController < ApplicationController
  before_filter :require_session, :only => [:edit, :update, :destroy]
  before_filter :check_permissions, :only => [:edit, :update, :destroy]

  # GET /companies
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
      format.json { render :json => @companies }
    end
  end

  # GET /companies/1
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
      format.json { render :json => @company }
    end
  end

  # GET /companies/new
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
      format.json { render :json => @company }
    end
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        flash[:success] = I18n.t(:'companies.created')
        format.html { redirect_to(@company) }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
        format.json { render :json => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
        format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:success] = I18n.t(:'companies.updated')
        format.html { redirect_to(@company) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
        format.json { render :json => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  protected
  
  def check_permissions
    @company = Company.find(params[:id])
    unless current_person and current_person.can_edit?(@company)
      flash[:error] = "You can only do that to your own data."
      redirect_to :back 
    end
  end

end
