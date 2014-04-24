class SearchesController < ApplicationController

  get '/all_searches' do
    service = SearchesService.new
    result = service.get_all_searches().to_a
    result.to_json
  end

  post '/add_search', :provides => :json do
    data = JSON.parse params
    # do something with the data, then…
    halt 200, data.to_json
  end

  delete '/search/:name' do |name|

  end


  get '/nodes/:search' do |search|

  end

  post '/add_node', :provides => :json do
    data = JSON.parse params
    # do something with the data, then…
    halt 200, data.to_json
  end

  delete '/node/:name' do |name|

  end

end