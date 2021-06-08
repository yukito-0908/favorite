class Public::InquiresController < ApplicationController

  def new
    @user = current_user
    @inquire = Inquire.new
  end

  # 確認画面を作成する場合はこのような記述になるかと思います。
  # newアクションから入力内容を受け取り、
  # 送信ボタンを押されたらcreateアクションを実行します。
  def confirm
    @user = current_user
    @inquire = Inquire.new(inquire_params)

    if @inquire.invalid?
      render :new
    end
  end

  # 入力内容に誤りがあった場合、
  # 入力内容を保持したまま前のページに戻るのが当たり前になっているかと思いますが、
  # backアクションを定義することで可能となります。
  def back
    @user = current_user
    @inquire = Inquire.new(inquire_params)
    render :new
  end

  # 実際に送信するアクションになります。
  # ここで初めて入力内容を保存します。
  # セキュリティーのためにも一定時間で入力内容の削除を行ってもいいかもしれません。
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

  # 送信完了画面を使用する場合お使いください。
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
