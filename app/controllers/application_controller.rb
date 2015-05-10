class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :user_timezone, if: :user_signed_in?

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || feed_path
  end

  private

  def user_timezone(&block)
    Time.use_zone(current_user.timezone, &block)
  end
end
