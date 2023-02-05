require 'recipe_repository'
require_relative '../lib/database_connection'

RSpec.describe RecipeRepository do 

  def reset_recipe_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end 

  before(:each) do 
    reset_recipe_table
  end 

  it 'returns all recipes' do
    repo = RecipeRepository.new
    recipe = repo.all

    expect(recipe.length).to eq 3 # => 3
    expect(recipe.first.id).to eq '1' # => 1
    expect(recipe.first.name).to eq 'Burrito' # => 'Burrito'
    expect(recipe.first.cooking_time).to eq '60 minutes' # => '60 minutes'
    expect(recipe.first.rating).to eq '5' # => 5
  end

  it 'returns Carbonara recipe' do
    repo = RecipeRepository.new
    recipe = repo.find(2)

    expect(recipe.id).to eq '2' # => 2
    expect(recipe.name).to eq 'Carbonara' # => 'Carbonara'
    expect(recipe.cooking_time).to eq '30 minutes' # => '30 minutes'
    expect(recipe.rating).to eq '3' # => 3
  end

  it 'returns Checkien Strogonoff recipe' do
    repo = RecipeRepository.new
    recipe = repo.find(3)

    expect(recipe.id).to eq '3' # => 3
    expect(recipe.name).to eq 'Chicken Strogonoff' # => 'Carbonara'
    expect(recipe.cooking_time).to eq '40 minutes' # => '30 minutes'
    expect(recipe.rating).to eq '5' # => 3
  end
end

      