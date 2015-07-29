class CarbonOperations::Carbon < CarbonOperations::Base
  Name = 'carbon'
  DisplayName = 'Carbon'

  def perform
    results_for(:habitat).to_json
  end
end
