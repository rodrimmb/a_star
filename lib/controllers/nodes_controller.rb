class NodesController < ApplicationController

  get '/all_nodes/:search' do |search|
    
  end

  get '/node/:search/:node' do |search, node|
    
  end

  post '/add_node/:search' do |search|
    puts "Add new node to #{search}"
    node = JSON.parse(request.body.read)
    puts node
  end

  delete 'delete_node/:search/:node_name' do |search, node|
    
  end

end