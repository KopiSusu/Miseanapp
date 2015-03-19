class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(current_user.id)
    @recipes = @user.recipes.all
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id # auto log in
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end
  
end
