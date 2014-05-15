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
		priority_queue.add_node(initial.state.value.to_i + initial.state.path_cost.to_i, initial)

		while !priority_queue.is_empty?
			@open = priority_queue.queue
			n = priority_queue.next

			if n.is_goal? 
				generate_operation(n, priority_queue.queue)
				return n.path
			end

			n.expand.each do |child|
				if not @closed.include?(child)
					priority_queue.add_node(child.state.value, child)
				end
			end
			generate_operation(n, priority_queue.queue)
			@closed << n
		end
		raise "Solution for A* not found"
	end

	private 

	def generate_operation(node, successors)
		open = create_node_info(node)

		list_successors = []
		successors.each do |n|
			list_successors << create_node_info(n)
		end

		list_closed = []
		@closed.each do |n|
			list_closed << create_node_info(n)
		end

		@operations << {
			"id" => @cont, 
			"open"=> open, 
			"successors" => list_successors,
			"closed" => list_closed
		}
		
		@cont += 1
	end

	def create_node_info(node)
		{	
			"name" => node.state.name, 
			"father" => node.state.father[0], 
			"cost" => node.state.value, 
			"path_cost" => node.state.path_cost
		}
	end
end