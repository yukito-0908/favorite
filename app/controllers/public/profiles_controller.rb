class Public::ProfilesController < ApplicationController

  def new
    @profile = Profile.new

  end

  def mypage
    @profiles = current_user.profiles
  end

  def edit
  end

  def create
    @profile = Profile.new(profiles_params)
    @profile.user_id = current_user.id
    @profile.save
    redirect_to post_images_path
  end

  def update
  end

  def show
  end

   protected

  def profiles_params
    params.require(:profile).permit(:instagram_id, :name, :introduction, :image)
  end

end
