class BooksController < ApplicationController
  before_action :access_restriction, only: [:edit, :update]

  def index
    @book_new = Book.new
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
  end

  def create
    @book_new = Book.new(book_params)
    # @book_new.user_id = current_user.id
    # puts @book.inspect
    @book_new.user_id = current_user.id

    if @book_new.save
      flash[:notice] = "you have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    # unless @user.id == current_user.id
      # redirect_to books_path
    # end
    # redirect_to book_path (@book.id)
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "you have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    # unless @user.id == current_user.id
    redirect_to books_path
    # end
  end

  private

  def access_restriction
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end