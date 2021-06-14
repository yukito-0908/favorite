class Public::RoomsController < ApplicationController

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to public_room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages.order("id DESC")
      @message = Message.new
      @entries = @room.entries
    else
      render :show
    end
  end

  def index
    @users = Kaminari.paginate_array(current_user.followings & current_user.followers).page(params[:page]).per(10)
  end

end
