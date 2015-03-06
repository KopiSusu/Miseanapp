require 'spec_helper'
require "rails_helper"

# test to make sure relationships are working

describe Ingredient do

  subject(:recipe) { Recipe.new }
  let(:ingredient) { Ingredient.new }

  describe "associations" do

    it "recipe should be able to get all its ingredients" do
      expect { recipe.ingredients }.not_to raise_error
    end

    it "ingredients should know all the recipes it belongs to" do
      expect { ingredient.recipes }.not_to raise_error
    end

    it "recipe should be able to set its ingredients" do
      expect { recipe.ingredients << ingredient }.not_to raise_error
    end

    it "ingredient should be able to set its recipes" do
      expect { ingredient.recipes << recipe }.not_to raise_error
    end

  end

end

describe Step do

  subject(:recipe) { Recipe.new }
  let(:step) { Step.new }

  describe "associations" do
    it "Recipe should be able to get its steps" do
      expect { recipe.steps }.not_to raise_error
    end

    it "Steps should know what recipe it belongs to" do
      expect { step.recipe }.not_to raise_error
    end

    it "Step should be able to set its recipe" do
      expect { step.recipe = recipe }.not_to raise_error
    end

    it "Recipe should be able to add more steps" do
      expect { recipe.steps << step }.not_to raise_error
    end
  end

end

describe Amount do

  # subject(:recipe) { Recipe.new }
  subject(:ingredient) { Ingredient.new }
  let(:amount) { Amount.new }

  describe "associations" do

    it "recipe should be able to get the amount of its ingredients" do
      expect { ingredient.amounts }.not_to raise_error
    end

    it "amounts should know the ingredients it belongs to" do
      expect { amount.ingredient }.not_to raise_error
    end

    it "ingredient should be able to set its amounts" do
      expect { ingredient.amounts << amount }.not_to raise_error
    end

    it "amount should be able to set its ingredient" do
      expect { amount.ingredient = ingredient }.not_to raise_error
    end

  end

end