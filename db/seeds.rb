# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


colors = ["Blue", "White", "Red", "Brown", "Black", "Yellow"]

random = [1, 2, 3]
70.times do |i|
  Post.create(
    title: "Post #{i}",
    brand_id: random.sample,
    user_id: 1,
    color: colors.sample,
    category_id: random.sample
  )
end
puts "Seeding complete."
#(1..20).each do |i|
	#Post.create(title: "Post #{i}", brand_id: 1, user_id: 1, color: "Blue")
#end

