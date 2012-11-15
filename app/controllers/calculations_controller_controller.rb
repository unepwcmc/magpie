class CalculationsControllerController < ApplicationController
  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @calculation = Calculation.find_by_code!(request.path_parameters[:code])
    render
  end
end
