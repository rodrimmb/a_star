class SearchesController < ApplicationController

  get '/all_searches' do
    #service = SearchesService.new
    result = @service.get_all_searches().to_a
    result.to_json
  end

  post '/add_search/:search' do |search|
    puts "Add new search: #{search}"
    #service = SearchesService.new
    @service.add_search(search)
  end

  delete '/search/:search' do |search|
    #service = SearchesService.new
    puts "Deleting #{search}"
    @service.delete_search(search)
    halt 200
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