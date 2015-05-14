class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
  	# devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :last_name, :address, :phone,:cell_phone, :role, :image) }
 	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password,:name, :last_name, :address, :phone,:cell_phone, :role, :image) }
  end

  private
  def set_current_project
    params[:person_has_project][:current_project] = true if params[:person_has_project][:finish_date].to_date > Date.today
    params[:person_has_project][:current_project] = false 
  end
end
