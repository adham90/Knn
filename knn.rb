class Knn
	def initialize()
	  @data = []
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
			distance = calculate_distance(instance, unkown_instance)
			next if instance == unkown_instance

			if nearest_neighbors.length < k
				nearest_neighbors << [distance, position]
				nearest_neighbors = sort_neighbors(nearest_neighbors)
			else
				max_distance = nearest_neighbors.last.first
				if distance < max_distance
					nearest_neighbors[k - 1] = [distance, position]
					nearest_neighbors = sort_neighbors(nearest_neighbors)
				end
			end
		end

		nearest_neighbors.map do	|neighbor|
			distance, position = neighbor
			[@position_to_id[position], distance]
		end
	end
	
	def sort_neighbors(nearest_neighbors)
		sort_neighbors.sort { |a, b| a[0] <=> b[0] }
	end
end 

