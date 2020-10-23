require 'pry'
require_relative '../config/environment.rb'

wolverine = Character.find_by(name: "Wolverine")
iron_man = Character.find_by(name: "Iron Man")
erick = User.find_by(name: "Erick")

puts " "
puts "CHARACTER"
puts "Returns a Characters Fans"
pp wolverine.get_fans == ["Erick"]
puts "Finds All Comics A Hero Is In"
pp iron_man.get_comics == ["Iron Man Comic vol 1","Iron Man Comic vol 2","Iron Man Comic vol 3","Iron Man Comic vol 4","Avenger vol 1","Avenger vol 2","Avenger vol 3"]
puts "Returns All Heros"
pp Character.all_heros == ["Spider-Man", "Wolverine", "Iron Man", "Hulk", "Black Panther"]

puts " "
puts "USER"
puts "Returns Array Of User's Favorite Characters"
pp erick.favorite_character == ["Wolverine", "Iron Man"]
# puts "Can Add Character To A Users Fav Character Array"
# pp erick.add_favorite_character("Iron Man")
pp Character.top_char

puts " "
puts "COMICS"
puts "Returns List Of Most Expensive Comics"
pp Comic.most_expensive_comics(10)