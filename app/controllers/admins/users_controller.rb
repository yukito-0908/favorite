class Admins::UsersController < ApplicationController

  def index
    @users = User.all.order("id DESC")
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

  def users_params
    params.require(:user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :is_active ,:image,:instagram_id,
    :introduction)
  end

end
