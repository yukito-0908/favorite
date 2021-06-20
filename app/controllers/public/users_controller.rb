class Public::UsersController < ApplicationController

  def mypage
    @user = current_user
  end

  def edit
     @user = User.find(params[:id])
  end

  def index
    @users = User.all.where(is_active: 'E').order("id DESC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
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

  def search_all
    @user = current_user
    @posts_all = Post.posts_all(params[:posts_all])
    @posts = Post.all.where(is_active: true).order("id DESC").page(params[:page]).per(10)
    if params[:ranking] =="1"
      @posts = Post.joins(:likes).group(:post_id).order('count(likes.user_id) desc').page(1).per(10)
    elsif params[:ranking] == "2"
      @posts = Post.joins(:comments).group(:post_id).order('count(comments.user_id) desc').page(1).per(10)
    elsif params[:ranking] == "3"
      @posts = Post.all.order(id: "DESC").page(1).per(10)
    end
  end



  def unsubscribe
    @user = User.find(params[:user_id])
  end

  def withdraw
    @user = User.find(params[:user_id])
    @user.update(is_active: 1)
    reset_session
    redirect_to root_path
  end



  def update
    @user = User.find(params[:id])
    @user.update(users_params)
    redirect_to  public_users_mypage_path
  end



  protected
  def users_params
    params.require(:user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :is_active, :image, :introduction,:password)
  end

end
