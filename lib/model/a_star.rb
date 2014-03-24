=begin
	La clase AStar extiende de la clase abstracta ShearchAlgorithm.

	ShearchAlgorithm nos obliga a implementar el metodo find_path 
	al que le pasaremos el nodo origen y el nodo destino y esta nos
	devolvera la ruta de los nodos por los que pasa para encontrar 
	la meta.
=end
require_relative './search_algorithm'
require_relative './priority_queue.rb'

class AStar < SearchAlgorithm
	
	attr_reader :operations

	def initialize()
		@open = []
		@closed = []
		@operations = []
		@cont = 1
	end

	def search(initial)
		priority_queue = PriorityQueue.new
		priority_queue.add_node(initial.state.value + initial.deep, initial)

		while !priority_queue.is_empty?
			@open = priority_queue.queue
			generate_operation

			n = priority_queue.next

			if n.is_goal? 
				return n.path
			end

			n.expand.each do |child|
				if not @closed.include?(child.state.name)
					priority_queue.add_node(child.state.value + child.deep, child)
				end
			end
			# Don't should give the name only the node
			@closed << n.state.name
		end
		raise "Solution for A* not found"
	end

	private 

	def generate_operation
		@operations << {"id" => @cont, "open"=> @open, "closed" => @closed}
		# Quit (Only for developing)
		#puts "#{@cont} #{@open} #{@closed}"
		@cont += 1
	end
end