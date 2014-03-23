class Web < ApplicationController

  helpers do
    def title
      if @title
        "#{@title}"
      else
        "My Web Page"
      end
    end
  end

  get '/' do 	
  	erb :index
  end

  get '/a_star' do
    @title = "Tables"
  	erb :"a_star"
  end
end