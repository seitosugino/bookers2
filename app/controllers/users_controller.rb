class UsersController < ApplicationController
 before_action :ensure_correct_user, only:[:edit]
 before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.reverse_order
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user)
    else
    render:edit
    end
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
     unless @user == current_user
     redirect_to user_path(current_user)
  end
 
  def correct_user
    @user = User.find(params[:id])
     redirect_to(root_url) unless @user == current_user
  end
 end
 
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
