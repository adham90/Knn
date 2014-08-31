require "#{File.dirname(__FILE__)}/knn.rb"

knn = Knn.new

data1 = [[0, 1],[1, 0]]
data2 = [[0, 0],[1, 0]]
data3 = [[0, 4],[1, 5]]
data4 = [[0, 6],[1, 6]]

# 1000.times do
# 	r = Random.new()
# 	data = [[r.rand(50), r.rand(1000)],[r.rand(50), r.rand(1000)]]
# 	knn.add_instance(data, "#{r.rand(50)}, #{r.rand(50)}")
# end

knn.add_instance(data1, "1, 0")
knn.add_instance(data2, "0, 0")
knn.add_instance(data3, "4, 5")
knn.add_instance(data4, "6, 6")

puts knn.find_nearest_neighbors(data1, 3).inspect