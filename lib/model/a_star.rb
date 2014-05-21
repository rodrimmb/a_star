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
		@successors = []
		@operations = []
		@cont = 1
	end

	def search(initial)
		priority_queue = PriorityQueue.new
		priority_queue.add_node(initial.state.value.to_i, initial)

		while !priority_queue.is_empty?
			# Open list has the nodes sort by their f(x)
			@open = priority_queue.queue

			# Grab the node with lowest f(x) from open
			n = priority_queue.next

			# Check if the node is a end case
			if n.is_goal? 
				generate_operation(@open, [], [])
				return n.path
			end

			node_to_delete = nil

			n.expand.each do |child|
				@successors << child
				# we have to check if the f(x) score is te shortest distance from start to current node (child)
				# if I have the child node in the open list I have to check which is the best and take it to open list
				if @open.include?(child)
					current = get_node_from_list(child,@open)
					
					@successors[@successors.find_index(child)].state.deleted = true
					if value_of(child) < value_of(current)
						priority_queue.delete(current)
						priority_queue.add_node(value_of(child), child)
						
						@successors[@successors.find_index(child)].state.deleted = false
						@open[@open.find_index(child)].state.deleted = true
					end
					# if I have the child node in the closed list I have to check which is the best and take it to open list
					# and remove from the closed list
				elsif @closed.include?(child)
					current = get_node_from_list(child, @closed) 
					
					@closed[@closed.find_index(child)].state.deleted = true
					if value_of(child) < value_of(current)
						# save the node to delet it when the trace will be save
						node_to_delete = current
						priority_queue.add_node(value_of(child), child)
					end
				else
					# if the node is not in open neither closed, I add it to priority queue
					priority_queue.add_node(value_of(child), child)
				end
			end
			# The node goes from open to closed list
			@closed << n

			generate_operation(@open, @successors, @closed)

			if node_to_delete != nil
				@closed.delete(node_to_delete)
			end
			
			# remove node from open list
			@open.delete(n)

			# Successors come back to be empty
			@successors = []
		end
		raise "Solution for A* not found"
	end

	private 

	def value_of(node)
		node.state.value.to_i + node.state.path_cost.to_i
	end

	def get_node_from_list(node, list)
		list.each do |element|
			if element == node
				return element
			end
		end
	end 

	def generate_operation(open, successors, closed)
		list_open = []
		open.each do |n|
			list_open << create_node_info(n)
		end

		list_successors = []
		successors.each do |n|
			list_successors << create_node_info(n)
		end

		list_closed = []
		closed.each do |n|
			list_closed << create_node_info(n)
		end

		@operations << {
			"id" => @cont, 
			"open"=> list_open, 
			"successors" => list_successors,
			"closed" => list_closed
		}
		
		@cont += 1
	end

	def create_node_info(node)
		{	
			"name" => node.state.name, 
			"father" => node.state.father[0], 
			"cost" => node.state.value.to_i + node.state.path_cost.to_i, 
			"path_cost" => node.state.path_cost,
			"deleted" => node.state.deleted
		}
	end
end