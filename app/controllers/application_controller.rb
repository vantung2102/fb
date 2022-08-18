class ApplicationController < ActionController::Base
    include Pagy::Backend
    include Pundit::Authorization

    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from Pundit::NotAuthorizedError, with: :post_not_authorized

    protected

    # def set_api_token(current_user)
    #     if user_signed_in?
    #       payload = current_user.generate_token
    #       cookies.permanent[:api_token] = payload
    #     end
    # end
    
    def configure_permitted_parameters
        added_attrs = [:name, :phone, :email, :password, :password_confirmation, :remember_me]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    private

    def post_not_authorized
        flash[:danger] = "You are not authorized to perform this action."
        redirect_back(fallback_location: root_path)
    end
end
