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
	
	attr_reader :open, :closed, :operations

	def initialize()
		@open = []
		@closed = []
		@operations = {}
		@cont = 1
	end

	def find_path(initial)
		priority_queue = PriorityQueue.new
		priority_queue.set_nodes([initial])
		@open = priority_queue.queue

		while !priority_queue.is_empty?
			generate_operation
			element = priority_queue.next
			
			@open = priority_queue.queue

			return element.path if element.is_goal?
			
			if (element.has_children?)
				@closed << element
				priority_queue.set_nodes(element.expand)
			end
		end
		raise "Solution not found"
	end

	private 

	def generate_operation
		puts "Este es el paso #{@cont} el tamaño de open es #{@open.size} y el de closed #{@closed.size}"
		@operations[@cont] = {"open" => open, "closed" => closed}
		@cont += 1
	end
end