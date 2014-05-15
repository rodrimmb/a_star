require_relative './application_controller.rb'
require 'json'

class SolutionController < ApplicationController

    get '/:search' do |search|
    	json obtain_solution(search)      
    end

    get '/path/:search' do |search|
        json obtain_path(search)
    end

    private

    def obtain_solution(search)
        if @searchesService.get_solution(search) == []
            a_star = AStar.new
            result = []
            nodes = NodesHandler.new(search, @nodesService)

            state = nodes.get_first_node()
            node = Node.new(state)
            solution = a_star.search(node)

            solution.each do |n|
                result << n.state.name
            end
            @searchesService.set_solution(search,result)
            result
        else
            @searchesService.get_solution(search)
        end
    end

    def obtain_path(search)
        a_star = AStar.new
        result = []
        nodes = NodesHandler.new(search, @nodesService)

        state = nodes.get_first_node()
        node = Node.new(state)
        solution = a_star.search(node)

        a_star.operations
    end
end