class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user! # -> check if user is logged in.

  include Pundit

  # Pundit: white-list approach.
  # authorizing 1 object
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # authorizing colleciton of objects
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
