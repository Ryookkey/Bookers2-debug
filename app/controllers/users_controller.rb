class UsersController < ApplicationController
  before_action :access_restriction, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
  end

  def create
    @book_new = Book.new(book_params)
    # puts @book.inspect
    @book_new.save
    # puts @book.id
    redirect_to book_path(@book_new)
  end

  def show
    # @image =
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to books_path
    end
    # redirect_to user_path(@user.id)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "you have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def access_restriction
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end
end