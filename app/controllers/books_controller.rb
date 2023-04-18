class BooksController < ApplicationController

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def show
    @book_id = Book.find(params[:id]) 
    @user = @book_id.user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
  book = Book.find(params[:id])
  book.destroy
  redirect_to "/books"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
