=begin
	La clase AStar extiende de la clase abstracta ShearchAlgorithm.

	ShearchAlgorithm nos obliga a implementar el metodo find_path 
	al que le pasaremos el nodo origen y el nodo destino y esta nos
	devolvera la ruta de los nodos por los que pasa para encontrar 
	la meta.
=end
require 'model/search_algorithm'
require 'model/priority_queue'

class AStar < SearchAlgorithm
	def initialize()
	
	end

	def find_path(initial, goal)
		priority_queue = PriorityQueue.new
		priority_queue.set_nodes([initial])

		while !priority_queue.is_empty?
			
			element = priority_queue.next
			return element.path if element.is_goal?
			
			if (element.has_children?)
				priority_queue.set_nodes(element.expand)
			end
		end
	end
end