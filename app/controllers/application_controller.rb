class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_project
  before_filter :parse_ie_json

  private

  def ensure_project
    if Apartment::Database.current_database.blank?
      render json: { error: 'Project not found' }
    end
  end

  # IE can't send a content-type cross-domain,
  # so try to parse JSON into the nested attribute hash
  # if content-type is nil
  def parse_ie_json
    if request.content_type.nil? && request.method == "POST"
      params[self._wrapper_options[:name].to_sym] = ActiveSupport::JSON.decode(request.body)
    end
  end
end
