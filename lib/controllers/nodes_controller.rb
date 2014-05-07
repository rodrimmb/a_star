class NodesController < ApplicationController

  get '/all_nodes/:search' do |search|
    @nodesService.get_all_nodes(search).to_json
  end

  get '/node/:search/:node' do |search, node|
    
  end

  post '/add_node/:search' do |search|
    puts "Add new node to #{search}"
    node = JSON.parse(request.body.read)

    @nodesService.add_node(node, search)
  end

  delete 'delete_node/:search/:node_name' do |search, node|
    
  end

end