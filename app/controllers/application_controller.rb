class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  before_filter :ensure_project

  private

  def not_found
    render :json => {error: "Resource not found"}
  end

  def ensure_project
    if Apartment::Database.current_database.blank?
      render :json => {error: "Project not found"}
    end
  end
end
