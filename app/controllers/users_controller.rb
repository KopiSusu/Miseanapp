class UsersController < ApplicationController  
  before_filter :restrict_access, :only => [:show]

  def index
  end

  def show
    @user = User.find(current_user.id)
    if params[:search]
      @recipes = @user.recipes.search(params[:search])
    else 
      @recipes = @user.recipes.all
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
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

