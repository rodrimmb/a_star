require_relative './application_controller.rb'
require 'json'

class SolutionController < ApplicationController

    get '/:search' do |search|
    	json obtain_solution(search)      
    end

    get '/path/:search' do |search|
        json obtain_path(search)
    end

    get '/graph/:search' do |search|
        g = GenerateGraph.new
        nodes = @searchesService.get_search_nodes(search)
        g.get_svg(nodes)
    end

    private

    def obtain_solution(search)
        if @searchesService.get_solution(search) == [] && @nodesService.get_all_nodes(search).size > 0
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
        if @searchesService.get_steps(search) == [] && @nodesService.get_all_nodes(search).size > 0
            a_star = AStar.new
            nodes = NodesHandler.new(search, @nodesService)

            state = nodes.get_first_node()
            node = Node.new(state)
            a_star.search(node)

            result = a_star.operations
            @searchesService.set_steps(search,result)
            result
        else
            @searchesService.get_steps(search)
        end
    end
end