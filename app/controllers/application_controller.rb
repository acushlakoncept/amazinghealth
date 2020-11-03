class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  layout :layout_by_resource

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :surname, :phone])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :surname, :phone, :avatar])
    end


    def layout_by_resource
      if devise_controller? && resource_name == :user && action_name == 'new'
        'account'
      else
        'application'
      end
    end
end
