class NodesController < ApplicationController

  get '/all_nodes/:search' do |search|
    result = @service.get_all_searches().to_a
    result.to_json
  end

  post '/add_node/:search' do |search|
    puts "Add new node to #{search}"
    node = JSON.parse(request.body.read)
    puts node
  end

  delete '/:search/:node_name' do |search, node|
    puts "Deleting node #{node} from #{search}"

    halt 200
  end


  get '/nodes/:search' do |search|

  end

  post '/add_node', :provides => :json do
    data = JSON.parse params
    # do something with the data, then…
    halt 200, data.to_json
  end

  delete '/node/:name' do |name|

  end

end