class HandlerJson
	
  def self.get_state(state_name)
  	output = JSON.parse(obtain_file)

		output.each do |state|
			if state["name"] == state_name
				return Example.new(state["value"], state["name"], state["goal"], state["children"])
			end
		end

	end

  def self.setstate(state)

  end

  def self.obtain_file
    resource = "./res/astar.json"
    File.read(resource)
  end
end