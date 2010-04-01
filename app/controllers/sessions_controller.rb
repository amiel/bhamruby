class SessionsController < ApplicationController
	 before_filter :require_no_session, :only => [:new, :create]
	 before_filter :require_session, :only => :destroy

	 def new
	   @session = PersonSession.new
	 end
  
	 def create
	   @session = PersonSession.new(params[:person_session])
	   if @session.save
     		flash[:notice] = "Welcome, #{@session.person.name}"
     		redirect_back_or_default @session.person
	   else
	     render :action => :new
	   end
	 end
    
   def close
     destroy
   end
      
	 def destroy
	   current_session.destroy if current_session
	   flash[:notice] = "Logout successful!"
	   redirect_back_or_default new_session_path
	 end
end
