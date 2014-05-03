class SearchesController < ApplicationController

  get '/all_searches' do
    result = @searchesService.get_all_searches().to_a
    result.to_json
  end

  post '/add_search/:search' do |search|
    puts "Add new search: #{search}"
    @searchesService.add_search(search)
  end

  delete '/search/:search' do |search|
    puts "Deleting #{search}"
    @searchesService.delete_search(search)
    halt 200
  end
end