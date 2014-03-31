require "sinatra/base"
require "sinatra/json"


class ApplicationController < Sinatra::Base
	helpers Sinatra::JSON

	helpers do

	    def title
	      if @title
	        "#{@title}"
	      else
	        "My Web Page"
	      end
	    end

	    def javascript
	    	@js = [
	    		'/js/w2ui-1.3.1.js',
	    		'/js/tables.js'
	    	]
		end

		def stylesheet
	    	@css = [
			'/css/style.css',
			'/css/w2ui-1.3.1.css'
			]
		end
  	end

	set :views         , File.expand_path('../../views', __FILE__)
  	set :public_folder , File.expand_path('../../public', __FILE__)
end