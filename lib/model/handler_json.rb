class HandlerJson
	
  def self.get_state(state_name)
  	output = JSON.parse(obtain_file)

		output.each do |state|
			if state["name"] == state_name
        if state["children"] != nil then children = state["children"] else children = [] end
				return Example.new(state["cost"], state["name"], state["goal"], children)
			end
		end

	end

  def self.setstate(state)

  end

  def self.obtain_file
    resource = "./public/res/astar.json"
    File.read(resource)
  end
end