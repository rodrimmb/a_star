class DataJson < ApplicationController

  post '/example' do
    res = "./public/res/astar.json" 
    file = File.read(res)
    output = JSON.parse '{ "status": "success", "total": 13, "records":'+ file +' }'
    json output
  end

  get '/exampleSolution' do
    res = "./public/res/astar.json" 
    file = File.read(res)
    output = JSON.parse '{ "status": "success", "total": 13, "records":'+ file +' }'
    json output
  end
end