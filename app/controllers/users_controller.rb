class UsersController < ApplicationController
  
  before_action :authenticate_user!

  before_action :ensure_correct_user, only:[:edit]
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = current_user.books
    @books = @user.books
  end

  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def index
    @users = User.all
    @user = current_user
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
      params.require(:user).permit(:name, :image, :introduction)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end
  
end
