class TenantsController < ApplicationController
  def index
    render :json => Analysis.all
  end
end
