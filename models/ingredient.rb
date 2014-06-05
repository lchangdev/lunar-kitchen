class Ingredient

  attr_reader :name, :id, :recipe_id
  def initialize(ingredients)
    @name = ingredients['name']
    @id = ingredients['id']
    @recipe_id = ingredients['recipe_id']
  end

end
