class SearchesController < ApplicationController

  get '/all_searches' do
    
  end

  post '/add_search', :provides => :json do
    data = JSON.parse params
    # do something with the data, then…
    halt 200, data.to_json
  end

  get '/nodes/:search' do

  end

  post '/add_node', :provides => :json do

  end

end