class Public::InquiresController < ApplicationController

  def new
    @user = current_user
    @inquire = Inquire.new
  end

  def confirm
    @user = current_user
    @inquire = Inquire.new(inquire_params)

    if @inquire.invalid?
      render :new
    end
  end

  
  def back
    @user = current_user
    @inquire = Inquire.new(inquire_params)
    render :new
  end

  
  def create
    @user = current_user
    @inquire = Inquire.new(inquire_param)
    if @inquire.save
      InquiryMailer.received_email(@inquiry).deliver
      redirect_to done_path
    else
      render :new
    end
  end

  def done
  end

  private

  def inquire_params
    params.permit(:email,:name,:message, :user_id)
  end

  def inquire_param
    params.require(:inquire).permit(:email,:name,:message, :user_id)
  end

end
