class Admins::SessionsController < Devise::SessionsController
  skip_before_filter :ensure_project
end
