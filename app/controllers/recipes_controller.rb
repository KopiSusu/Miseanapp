class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path
    else
      render :new
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

