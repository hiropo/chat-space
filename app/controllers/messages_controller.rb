class MessagesController < ApplicationController
  before_action :get_groups
  before_action :set_group

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)

  end

  def create
    @message = Message.new(message_params)
    @messages = @group.messages.includes(:user)
    if @message.save
      redirect_to group_messages_path, notice: "メッセージを作成しました。"
    else 
      flash[:alert] = 'メッセージを入力してください'
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id], user_id: current_user.id )
  end

  def get_groups
    @groups = current_user.groups
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_messages
    @messages = @group.messages.includes(:user)
  end
end
