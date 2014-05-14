require_relative './application_controller.rb'

class SolutionController < ApplicationController

    get '/solution/:search' do |search|
  		a_star = AStar.new
  		
  		collection = SingletonDbConnection.get_instance('mydb','testData')
  		node_service = Nodeservice.new(collection)
  		nodes = NodesHandler.new(search, nodes_service)

  		state = 
  		node = Node.new(state)
  		solution = a_star.search(node)

    end

    get '/solution_path/:search' do |search|
    
    end
end