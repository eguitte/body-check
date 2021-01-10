class ChatsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    if @chat.save
      redirect_to request.referer
    else
      @chats = current_user.chats.order(id: :desc).page(params[:page]).per(50)
      flash.now[:danger] = '送信に失敗しました。'
      render chat_path(current_user)
    end
  end
  
  def destroy
    @chat.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: chat_path(current_user))
  end
  
  private
 
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  def correct_user
    @chat = current_user.chats.find_by(id: params[:id])
    unless @chat
      redirect_to root_url
    end
  end
end