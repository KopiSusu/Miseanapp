class RecipesController < ApplicationController

  before_filter :restrict_access

  def index
    @recipes = Recipe.where(user_id: current_user.id)
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

    if @recipe.update_attributes(update_recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def create
    if params[:url].blank?
      redirect_to new_recipe_path
    elsif params[:url]
      scraper = Scraper.new(params[:url])
      title = scraper.get_properties('#headline > h1:first-child')[0]
      if scraper.get_properties('.summary_data > span')[0] == nil
        serving = 1
      else
        serving = scraper.get_properties('.summary_data > span')[0].scan(/\d+/).first.to_r.to_f 
      end
      photourl = scraper.get_img
      @recipe = Recipe.new(title: title, serving: serving, photo: photourl)

      ingredients = scraper.get_properties('.ingredient')
      for ingredient in ingredients do
        amount = ingredient.split(/[a-zA-Z]/)[0]
        amounts = amount.split(" ")
        amount_integer = amounts[1].to_r.to_f + amounts[0].to_r.to_f
        ingredient.slice! amount
        @recipe.ingredients << Ingredient.new(name: ingredient)
        if amount_integer > 0
          @recipe.ingredients.last.amounts << Amount.new(quantity: amount_integer)
        end
      end

      steps = scraper.get_properties('#preparation > p')
      for step in steps do
        @recipe.steps << Step.new(instruction: step)
      end
      @recipe.user_id = current_user.id
      @recipe.save
      redirect_to edit_recipe_path(@recipe.id)
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

  def update_recipe_params
    params.require(:recipe).permit(
      :title, :picture_url
    )
  end

end


