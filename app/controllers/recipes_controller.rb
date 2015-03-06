class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    1.times do
      ingredient = @recipe.ingredients.build
      1.times { ingredient.amounts.build }
    end
    1.times { @recipe.steps.build }
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update_attributes(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def create
    if params[:url]
      @scraper = Scraper.new(params[:url])
      @title = @scraper.get_properties('#headline > h1:first-child')[0]
      @recipe = Recipe.new(title: @title)

      @ingredients = @scraper.get_properties('.ingredient')
      for ingredient in @ingredients do
        split = ingredient.rpartition(/[0-9]/)
        amount = split[0] + split[1]
        amounts = amount.split(" ")
        amount_integer = amounts[1].to_r.to_f + amounts[0].to_r.to_f 
        type = split[2]
        @recipe.ingredients << Ingredient.new(name: type)
        @recipe.ingredients.last.amounts << Amount.new(quantity: amount_integer)
      end
      # problem now is that this fucks up when there is 2 sets of numbers in an ingredient, for instance when someone says "2 1/4 teaspons sugar (around 1 tablesoon)"

      @steps = @scraper.get_properties('#preparation > p')
      for step in @steps do
        @recipe.steps << Step.new(instruction: step)
      end
      @recipe.save
      redirect_to recipes_path
    else
      @recipe = Recipe.new(recipe_params)
      if @recipe.save
        redirect_to recipes_path
      else
        render :new
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  protected

  def recipe_params
    params.require(:recipe).permit(
      :title, :picture_url, steps_attributes: [:instruction], ingredients_attributes: [ :name, amounts_attributes: [:quantity]]
    )
  end

end

