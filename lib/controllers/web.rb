class Web < ApplicationController

  get '/' do 	
  	erb :index
  end

  get '/example' do
    @title = "Example Tables"
  	erb :"example"
  end
end