class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_project

  private

  def ensure_project
    if Apartment::Database.current_database.blank?
      render json: { error: 'Project not found' }
    end
  end
end
