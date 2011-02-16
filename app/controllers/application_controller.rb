# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_session, :current_person, :can_i_edit
  
    def can_i_edit(object)
      current_person and current_person.can_edit?(object)
    end

    def current_session
      return @current_session if defined?(@current_session)
      @current_session = PersonSession.find
    end

    def current_person
      return @current_person if defined?(@current_person)
      @current_person = current_session && current_session.person
      logger.debug "ApplicationController::current_person set @current_person => #{@current_person}"
      return @current_person
    end

    def require_session
      unless current_session
        store_location
        flash[:error] = "You must be logged in to access that page."
        redirect_to new_session_path
        return false
      end
    end
 
    def require_no_session
      if current_session
        store_location
        flash[:error] = "You must be logged out to access that page."
        redirect_to current_person
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def render_404
      respond_to do |format|
        format.html { render :file => "#{RAILS_ROOT}/public/404.html", :status => '404 Not Found' }
        format.xml  { render :nothing => true, :status => '404 Not Found' }
      end
      true
    end

    def rescue_action_in_public(e)
      case e 
      when ActiveResource::ResourceNotFound
        render_404
      when ActionController::RedirectBackError
        redirect_to '/'
      when ActionView::MissingTemplate
        render_404
      else
        super
      end
    end
    
end
