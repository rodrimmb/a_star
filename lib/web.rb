require 'sinatra'
require 'json'
require_relative './model/node.rb'
require_relative './model/example.rb'
require_relative './model/search_state.rb'
require_relative './model/a_star.rb'
require_relative './model/search_algorithm.rb'

helpers do
  def title
    if @title
      "#{@title}"
    else
      "My Web Page"
    end
  end
 
end

get '/' do 	
	erb :index
end

get '/a_star' do
	erb :"a_star"
end

post '/data/example' do
  res = "./res/astar.json" 
  json = File.read(res)
  output = JSON.parse '{ "status": "success", "total": 13, "records":'+ json +' }'
  output.to_json
end

post '/data/exampleSolution' do
  
end