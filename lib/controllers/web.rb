class Web < ApplicationController

  get '/' do 	
  	erb :index
  end

  get '/a_star' do
    @title = "Tables"
  	erb :"a_star"
  end
end