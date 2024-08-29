class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    players_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You do not have access to this page."
    end
  end
end
