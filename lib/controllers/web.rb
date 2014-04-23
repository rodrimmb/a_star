class Web < ApplicationController

  get '/' do 	
  	erb :index
  end

  get '/example' do
    @title = "Example Tables"
  	erb :"example"
  end

  get '/work_space/:search_name' do
    @title = "Work Space"
  	erb :"work_space"
  end
end