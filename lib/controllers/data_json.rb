class DataJson < ApplicationController

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




  get '/example_json' do
    res = "./public/res/astar.json" 
    file = File.read(res)
    output = JSON.parse file
    json output
  end

  post '/solution' do
    aStar = AStar.new
    initial = Node.new(HandlerJson.get_state("A", "./public/res/astar.json"))
    @path = aStar.search(initial)
    output = JSON.parse "{ \"status\": \"success\", \"total\": #{aStar.operations.size}, \"records\": #{create_json_solution(aStar.operations)}}"
    json output
  end

  get '/path_solution_json' do
    aStar = AStar.new
    initial = Node.new(HandlerJson.get_state("A", "./public/res/astar.json"))
    path = aStar.search(initial)
    
    solution = []
    path.each do |node|
      solution << node.state.name
    end
    output = JSON.parse(solution.to_s)
    json output
  end 

  post '/path_solution' do
    aStar = AStar.new
    initial = Node.new(HandlerJson.get_state("A", "./public/res/astar.json"))
    path = aStar.search(initial)
    
    solution = []
    path.each do |node|
      solution << node.state.name
    end

    output = JSON.parse(solution.to_s)
    json output
  end 

  get '/solution_json' do
    aStar = AStar.new
    initial = Node.new(HandlerJson.get_state("A", "./public/res/astar.json"))
    path = aStar.search(initial)
    output = JSON.parse "{ \"status\": \"success\", \"total\": #{aStar.operations.size}, \"records\": #{create_json_solution(aStar.operations)}}"
    json output
  end

  private 

  def create_json_solution(solution)
    array = "["
    solution.each_with_index do |item, index|
      array += "{\"recid\": #{item["id"]}, \"open\": #{item["open"]}, \"closed\": #{item["closed"]} }"
      if index < solution.size-1
        array += ","
      end
    end
    array +="]"
    array
  end


end