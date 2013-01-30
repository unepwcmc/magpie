class CartodbPolygonBuildWorker
  include Sidekiq::Worker

  def perform
    require 'httmultiparty' 
     
    file = File.open('/path/to/your/file.zip') 
     
    response = HTTMultiParty.post('https://your_user.cartodb.com/api/v1/imports', :query => {:file => file, :api_key => 'your_api_key'})
     
    upload_result = JSON.parse(response.body)
     
    # loop until you get {'sucess': 'true'} from the next request
    success = false
    until success do
      response = HTTParty.get("https://your_user.cartodb.com/api/v1/imports/#{upload_result['item_queue_id']}", :query => {:api_key => 'your_api_key'})
      success = JSON.parse(response.body)['success'] == 'true'
    end
  end
end
