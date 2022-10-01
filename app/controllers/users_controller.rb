class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(current_user.id), notice: 'Welcome! You have signed up successfully.'
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
    redirect_to user_path(current_user.id)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.following_user.all
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user.all
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end