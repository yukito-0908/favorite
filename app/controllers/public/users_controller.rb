class Public::UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_followers = @user.followings
    @user_following = @user.followers
    @profile = @user.profiles
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def update
    @user = current_user
    @user.update(users_params)
    redirect_to public_user_path(@user.id)
  end


  def users_params
    params.require(:user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :is_active, :image)
  end

end
