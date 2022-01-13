class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    
    def log_in(user)
        session[:user_id] = user.id
    end
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    def logged_in?
      !current_user.nil?
    end

       
    def logged_in_user
      unless logged_in?
        flash[:notice] = t('notice.not_login')
        redirect_to login_path
      end
    end
 
end
