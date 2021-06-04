class Public::ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def mypage
    @user = current_user
    @profiles = current_user.profiles
    @profile = @profiles.first

  end

  def show
    @profile = Profile.find(params[:id])
    @posts = @profile.posts.left_joins(:likes).group(:id).order('count(likes.id) desc')
    @profiles = current_user.profiles
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def create
    @user_all = current_user
    @user = User.update(
      is_active: "F"
    )
    @profile = Profile.new(profiles_params)
    @profiles = current_user.profiles
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to  public_profile_path(@profile.id)
    else
      render :new
    end
  end

  def index
    @profiles = current_user.profiles
     #@user = current_user
  end

  def update
    @profile = Profile.find(params[:id])
    if  @profile.update(profiles_params)
      redirect_to public_profile_path(@profile.id)
    else
      render :edit
    end
  end


   protected

  def profiles_params

    params.require(:profile).permit(:instagram_id, :name, :introduction, :image ,:is_active, :user_id)

  end

end
