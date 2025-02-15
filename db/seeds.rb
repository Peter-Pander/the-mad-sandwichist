puts "Cleaning database..."
IngredientTrait.destroy_all
SandwichIngredient.destroy_all
Trait.destroy_all
Ingredient.destroy_all
Sandwich.destroy_all
User.destroy_all

puts "Creating users..."
users = [
  { username: "TestyTesterson", email: "t_testerson@example.com", password: "password123"}
]

users.each do |user_data|
  user = User.create!(user_data)
  puts "Created user: #{user.username}" # Confirm user creation
end

puts "Creating Traits..."
traits = [
  { name: "sweet", trait_type: "flavor" },
  { name: "sour", trait_type: "flavor" },
  { name: "bitter", trait_type: "flavor" },
  { name: "salty", trait_type: "flavor" },
  { name: "savory", trait_type: "flavor" },
  { name: "soft", trait_type: "texture" },
  { name: "crunchy", trait_type: "texture" },
  { name: "chewy", trait_type: "texture" },
  { name: "creamy", trait_type: "texture" },
  { name: "viscous", trait_type: "texture" },
  { name: "Germany", trait_type: "country" },
  { name: "France", trait_type: "country" },
  { name: "Italy", trait_type: "country" },
  { name: "Japan", trait_type: "country" },
  { name: "China", trait_type: "country" },
  { name: "Mexico", trait_type: "country" },
  { name: "USA", trait_type: "country" },
  { name: "East Asia", trait_type: "region" },
  { name: "South East Asia", trait_type: "region" },
  { name: "Europe", trait_type: "region" },
  { name: "Central America", trait_type: "region" },
  { name: "South America", trait_type: "region" },
  { name: "Northern Africa", trait_type: "region" },
  { name: "Southern Africa", trait_type: "region" },
  { name: "Worldwide", trait_type: "region" }
]

traits.each do |trait_data|
  trait = Trait.create!(trait_data)
  puts "Created trait: #{trait.name}" # Confirm user creation
end

puts "Creating Ingredients..."
ingredients = [
  { name: "Pretzel Bun", description: "A soft, chewy bun with a dark crust and a hint of salt.",
  ingr_type: "bread", unit_of_measure: "slice", image_url: "wire_bun_top_am_gw1yd9" },

  { name: "Beef Patty", description: "Placeholder....",
  ingr_type: "patty", unit_of_measure: "patty" , image_url: "wire_patty_am_drtzlf" },

  { name: "Sliced Cheddar Cheese", description: "Placeholder....",
  ingr_type: "topping", unit_of_measure: "slice", image_url: "wire_slice_am_yeoosm" },

  { name: "Ketchup", description: "Placeholder....",
  ingr_type: "sauce", unit_of_measure: "tablespoon", image_url: "wire_puddle_am_xbganb" },

  { name: "Pretzel Bun (bottom)", description: "A soft, chewy bun with a dark crust and a hint of salt.",
  ingr_type: "bread", unit_of_measure: "slice", image_url: "wire_patty_am_drtzlf" },

  { name: "Kaiser Roll", description: "Placeholder....",
  ingr_type: "bread", unit_of_measure: "slice", image_url: "wire_puddle_am_xbganb" },

  { name: "Lettuce", description: "Placeholder....",
  ingr_type: "topping", unit_of_measure: "leaf", image_url: "wire_puddle_am_xbganb" },
  { name: "Sliced Tomato", description: "Placeholder....",
  ingr_type: "topping", unit_of_measure: "slice", image_url: "wire_puddle_am_xbganb" },
  { name: "Diced Onion", description: "Placeholder....",
  ingr_type: "topping", unit_of_measure: "cup", image_url: "wire_puddle_am_xbganb" },
  { name: "Bacon", description: "Placeholder....",
  ingr_type: "topping", unit_of_measure: "strip", image_url: "wire_puddle_am_xbganb" },

  { name: "Mustard", description: "Placeholder....",
  ingr_type: "sauce", unit_of_measure: "tablespoon", image_url: "wire_puddle_am_xbganb" },

  { name: "Fried Chicken Patty", description: "Placeholder....",
  ingr_type: "patty", unit_of_measure: "patty", image_url: "wire_puddle_am_xbganb" },

]

ingredients.each do |ingredient_data|
  ingredient = Ingredient.create!(ingredient_data)
  puts "Created ingredient: #{ingredient.name}" # Confirm user creation
end

puts "Adding traits to ingredients..."
ingr_traits = [
  { ingredient_id: Ingredient.find_by(name: "Pretzel Bun").id, trait_id: Trait.find_by(name: "savory").id },
  { ingredient_id: Ingredient.find_by(name: "Pretzel Bun").id, trait_id: Trait.find_by(name: "chewy").id },
  { ingredient_id: Ingredient.find_by(name: "Pretzel Bun").id, trait_id: Trait.find_by(name: "Germany").id },
  ###
  { ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id, trait_id: Trait.find_by(name: "sweet").id },
  { ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id, trait_id: Trait.find_by(name: "soft").id },
  { ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id, trait_id: Trait.find_by(name: "Germany").id },
  ###
  { ingredient_id: Ingredient.find_by(name: "Sliced Cheddar Cheese").id, trait_id: Trait.find_by(name: "sour").id },
  { ingredient_id: Ingredient.find_by(name: "Sliced Cheddar Cheese").id, trait_id: Trait.find_by(name: "soft").id },
  { ingredient_id: Ingredient.find_by(name: "Sliced Cheddar Cheese").id, trait_id: Trait.find_by(name: "USA").id },
  ###
  { ingredient_id: Ingredient.find_by(name: "Lettuce").id, trait_id: Trait.find_by(name: "bitter").id },
  { ingredient_id: Ingredient.find_by(name: "Lettuce").id, trait_id: Trait.find_by(name: "crunchy").id },
  { ingredient_id: Ingredient.find_by(name: "Lettuce").id, trait_id: Trait.find_by(name: "Worldwide").id },
  ###
  { ingredient_id: Ingredient.find_by(name: "Diced Onion").id, trait_id: Trait.find_by(name: "sweet").id },
  { ingredient_id: Ingredient.find_by(name: "Diced Onion").id, trait_id: Trait.find_by(name: "crunchy").id },
  { ingredient_id: Ingredient.find_by(name: "Diced Onion").id, trait_id: Trait.find_by(name: "Worldwide").id },
  ###
  { ingredient_id: Ingredient.find_by(name: "Bacon").id, trait_id: Trait.find_by(name: "savory").id },
  { ingredient_id: Ingredient.find_by(name: "Bacon").id, trait_id: Trait.find_by(name: "chewy").id },
  { ingredient_id: Ingredient.find_by(name: "Bacon").id, trait_id: Trait.find_by(name: "Worldwide").id },
  ###
  { ingredient_id: Ingredient.find_by(name: "Mustard").id, trait_id: Trait.find_by(name: "sour").id },
  { ingredient_id: Ingredient.find_by(name: "Mustard").id, trait_id: Trait.find_by(name: "viscous").id },
  { ingredient_id: Ingredient.find_by(name: "Mustard").id, trait_id: Trait.find_by(name: "Europe").id },
  ###
  { ingredient_id: Ingredient.find_by(name: "Beef Patty").id, trait_id: Trait.find_by(name: "savory").id },
  { ingredient_id: Ingredient.find_by(name: "Beef Patty").id, trait_id: Trait.find_by(name: "soft").id },
  { ingredient_id: Ingredient.find_by(name: "Beef Patty").id, trait_id: Trait.find_by(name: "Worldwide").id },
  ###
  { ingredient_id: Ingredient.find_by(name: "Fried Chicken Patty").id, trait_id: Trait.find_by(name: "savory").id },
  { ingredient_id: Ingredient.find_by(name: "Fried Chicken Patty").id, trait_id: Trait.find_by(name: "crunchy").id },
  { ingredient_id: Ingredient.find_by(name: "Fried Chicken Patty").id, trait_id: Trait.find_by(name: "Worldwide").id }
  ###
]

ingr_traits.each do |ingr_trait_data|
  ingr_trait = IngredientTrait.create!(ingr_trait_data)
  puts "Applied traits to ingredient: #{ingr_trait.id}" # Confirm user creation
end

puts "Creating Sandwiches..."
sandwiches = [
  { user_id: User.first.id, name: "Cheese Burger", description: "placeholder..." },
  { user_id: User.first.id, name: "Double Cheese Burger", description: "placeholder..." },
  { user_id: User.first.id, name: "Bacon Crispy Chicken", description: "placeholder..." },
]

sandwiches.each do |sandwich_data|
  sandwich = Sandwich.create!(sandwich_data)
  puts "Created sandwich: #{sandwich.name}" # Confirm user creation
end

puts "Adding ingredients to sandwiches..."
sandwich_ingr = [
  { sandwich_id: Sandwich.find_by(name: "Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id,
    ingredient_qty: 1, ingredient_position: 4 },
  { sandwich_id: Sandwich.find_by(name: "Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Sliced Cheddar Cheese").id,
    ingredient_qty: 1, ingredient_position: 3 },
  { sandwich_id: Sandwich.find_by(name: "Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Beef Patty").id,
    ingredient_qty: 1, ingredient_position: 2 },
  { sandwich_id: Sandwich.find_by(name: "Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id,
    ingredient_qty: 1, ingredient_position: 1 },
  ###
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id,
    ingredient_qty: 1, ingredient_position: 6 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Sliced Cheddar Cheese").id,
    ingredient_qty: 1, ingredient_position: 5 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Beef Patty").id,
    ingredient_qty: 1, ingredient_position: 4 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Sliced Cheddar Cheese").id,
    ingredient_qty: 1, ingredient_position: 3 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Beef Patty").id,
    ingredient_qty: 1, ingredient_position: 2 },
  { sandwich_id: Sandwich.find_by(name: "Double Cheese Burger").id,
    ingredient_id: Ingredient.find_by(name: "Kaiser Roll").id,
    ingredient_qty: 1, ingredient_position: 1 },
  ###
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Pretzel Bun").id,
    ingredient_qty: 1, ingredient_position: 7 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Mustard").id,
    ingredient_qty: 1, ingredient_position: 6 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Lettuce").id,
    ingredient_qty: 1, ingredient_position: 5 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Diced Onion").id,
    ingredient_qty: 1, ingredient_position: 4 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Bacon").id,
    ingredient_qty: 1, ingredient_position: 3 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Fried Chicken Patty").id,
    ingredient_qty: 1, ingredient_position: 2 },
  { sandwich_id: Sandwich.find_by(name: "Bacon Crispy Chicken").id,
    ingredient_id: Ingredient.find_by(name: "Pretzel Bun").id,
    ingredient_qty: 1, ingredient_position: 1 }
  ###
]

sandwich_ingr.each do |sandwich_ingr_data|
  sandwich_ingr = SandwichIngredient.create!(sandwich_ingr_data)
  puts "Applied ingredients to sandwich: #{sandwich_ingr.id}" # Confirm user creation
end
