require_relative './application_controller.rb'
require 'json'

class SolutionController < ApplicationController

    get '/:search' do |search|
    		a_star = AStar.new
        text = []
    		
    		collection = SingletonDbConnection.get_instance('mydb','testData')
    		nodes_service = NodesService.new(collection)
    		nodes = NodesHandler.new(search, nodes_service)

    		state = nodes.get_first_node()
    		node = Node.new(state)
    		solution = a_star.search(node)

        solution.each do |n|
            text << n.state.name
        end
        json text      
    end

    get '/path/:search' do |search|
    
    end
end