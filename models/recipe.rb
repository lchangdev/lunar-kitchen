class Recipe
  attr_reader :name, :id, :description, :instructions

  def initialize(recipes)
    @name = recipes['name']
    @id = recipes['id']

    if recipes['description'].nil?
      @description = "This recipe doesn't have a description."
    else
      @description = recipes['description']
    end
    if recipes['instructions'].nil?
      @instructions = "This recipe doesn't have any instructions."
    else
      @instructions = recipes['instructions']
    end
    # ingredient name method goes here
  end

  def self.all
    connection = PG.connect(dbname: 'recipes')
    recipes = connection.exec('SELECT * FROM recipes')
    connection.close

    @recipes = []
    recipes.each do |recipe|
      @recipes << Recipe.new(recipe)
    end
    @recipes
  end

  def self.find(params)
    recipe_detail = nil
    @recipes.each do |recipe|
      if params == recipe.id
        recipe_detail = recipe
      end
    end
    recipe_detail
  end

  def ingredients
    connection = PG.connect(dbname: 'recipes')

    ingredient_details= connection.exec("SELECT ingredients.name
      FROM ingredients
      WHERE recipe_id = #{@id}")
    connection.close

    ingredient_final = []
    ingredient_details.to_a.each do |ingredient|
      ingredient_final << Ingredient.new(ingredient)
    end
    ingredient_final
  end

end
