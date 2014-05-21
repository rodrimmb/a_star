require 'json'

class NodesController < ApplicationController

    get '/all_nodes/:search' do |search|
        @nodesService.get_all_nodes(search).to_json
    end

    get '/node/:search/:node' do |search, node|
      
    end

    post '/add_node/:search' do |search|
          @searchesService.remove_solution(search)
          @searchesService.remove_steps(search)
          node = JSON.parse(request.body.read)
          @nodesService.add_node(node, search)
          halt 200
    end

    delete 'delete_node/:search/:node_name' do |search, node|
      
    end

end