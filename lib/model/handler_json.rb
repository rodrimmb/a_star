class HandlerJson
	def self.get_state(state_name)
		resource = "./res/astar.json"
		json = File.read(resource)
  		output = JSON.parse(json)

  		output.each do |state|
  			if state["name"] == state_name
  				return Example.new(state["value"], state["name"], state["goal"], state["children"])
  			end
  		end
	end
end