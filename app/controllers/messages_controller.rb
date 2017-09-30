class MessagesController < ApplicationController

  def index
    @groups = current_user.groups
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to group_messages_path, notice: "メッセージを作成しました。"
    else 
      redirect_to group_messages_path, alert: "メッセージを入力して下さい"
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id], user_id: current_user.id )
  end

end