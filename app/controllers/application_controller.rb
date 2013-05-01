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
      request_json = ActiveSupport::JSON.decode(request.body)
      wrap_model_params_for_ie(request_json)
    end
  end

  # Replicates the rails functionality of wrapping parameters:
  # https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/params_wrapper.rb
  # but does it in the controller, for use with IE
  def wrap_model_params_for_ie request_json
    model_params = strip_non_model_safe_params(request_json)
    params[self._wrapper_options[:name].to_sym] = model_params
  end

  # Copied from the rails src:
  # https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/params_wrapper.rb#L261
  # Strips out parameters which aren't whitelisted to save on the model
  def strip_non_model_safe_params parameters
    safe_params = if include_only = self._wrapper_options[:include]
      parameters.slice(*include_only)
    else
      exclude = _wrapper_options[:exclude] || []
      parameters.except(*(exclude + EXCLUDE_PARAMETERS))
    end 
    return safe_params
  end
end
