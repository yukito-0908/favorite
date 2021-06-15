class Admins::UsersController < ApplicationController

  def index
    @users = User.all.order("id DESC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end



  def update
    @user = User.find(params[:id])
    if  @user.update(users_params)
      redirect_to admins_user_path(@user.id)
    else
      render :edit
    end
  end
  
  protected

  def users_params
    params.require(:user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :is_active ,:image,:instagram_id,
    :introduction)
  end

end
