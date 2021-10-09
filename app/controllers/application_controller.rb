class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    helper_method :current_user, :logged_in?
    
    def logged_in?
        !!session[:user_id]
    end

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end
end
