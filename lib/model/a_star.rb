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
		@expanded = []
		@operations = []
		@cont = 1
	end

	def search(initial)
		priority_queue = PriorityQueue.new
		priority_queue.add_node(initial.state.value.to_i + initial.state.path_cost.to_i, initial)

		while !priority_queue.is_empty?
			# Open list has the nodes sort by their f(x)
			@open = priority_queue.queue

			# Grab the node with lowest f(x) from open
			n = priority_queue.next

			# Check if the node is a end case
			if n.is_goal? 
				#generate_operation(n, priority_queue.queue)
				return n.path
			end

			# The node goes from open to closed list
			@open.delete(n)
			@closed << n

			n.expand.each do |child|
				# we have to check if the f(x) score is te shortest distance from start to current node (child)

				if not @closed.include?(child)
					priority_queue.add_node(child.state.value.to_i + child.state.path_cost.to_i, child)
				end
			end
			#generate_operation(n, priority_queue.queue)
			
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