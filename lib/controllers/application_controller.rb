require "sinatra/base"
require "sinatra/json"


class ApplicationController < Sinatra::Base
	helpers Sinatra::JSON

	set :views         , File.expand_path('../../views', __FILE__)
  	set :public_folder , File.expand_path('../../public', __FILE__)
end