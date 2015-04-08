class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :user_timezone, if: :user_signed_in?

  private

  def user_timezone(&block)
    Time.use_zone(current_user.timezone, &block)
  end
end
