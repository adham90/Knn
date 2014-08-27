#!/usr/bin/env ruby



class Knn
	def initialize()
	  @data           = []
	  @id_to_position = {}
	  @position_to_id = {}
	end

	def add_instance(instance_data, id)
		@data << instance_data
		
		position                  = @data.length - 1
		@id_to_position[id]       = position
		@position_to_id[position] = id
	end

	def get_instance_for_id(id)
		@data[@id_to_position[id]]
	end

	def find_nearest_neighbors(unkown_instance, k, ignore_duplicates = 0)
		nearest_neighbors = []

		@data.each_with_index do |instance, position|
			distance = euclidean_distance(instance, unkown_instance)
			next if instance == unkown_instance

			if nearest_neighbors.length < k
				nearest_neighbors << [distance, position]
				nearest_neighbors = sort_neighbors(nearest_neighbors)
			else
				max_distance = nearest_neighbors.last.first
				if distance < max_distance
					nearest_neighbors[k - 1] = [distance, position]
					nearest_neighbors        = sort_neighbors(nearest_neighbors)
				end
			end
		end

		nearest_neighbors.map do	|neighbor|
			distance, position = neighbor
			[@position_to_id[position], distance]
		end
	end
	
	def sort_neighbors(nearest_neighbors)
		nearest_neighbors.sort { |a, b| a[0] <=> b[0] }
	end

	def zip_sparse_arrays(instance1, instance2, &block)
		position1 = 0
		position2 = 0

		current1  = instance1[position1]
		current2  = instance2[position2]

		while (position1 < instance1.length || position2 < instance2.length)
			column1, value1 = current1
			column2, value2 = current2
			
			column1 ||= column2
			column2 ||= column1
			value1  ||= value2
			value2  ||= value1

			if column1 == column2
				block.call(value1, value2)
				position1 += 1
				position2 += 1
				current1   = instance1[position1]
				current2   = instance2[position2]
			elsif column1 < column2
				block.call(value1, 0)
				position1 += 1
				current1   = instance1[position1]
			else
				block.call(0, value2)
				position2 += 1
				current2   = instance2[position2]
			end
		end
	end

	def euclidean_distance(instance1, instance2)
		total_distance = 0.0
		zip_sparse_arrays(instance1, instance2) do |value1, value2|
			total_distance += (value1 - value2) ** 2
		end
		Math.sqrt(total_distance)
	end
end 

