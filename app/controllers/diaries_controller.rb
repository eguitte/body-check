class DiariesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :update, :edit]
  
  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      flash[:success] = '記録しました！'
      redirect_to diaries_user_path(current_user)
    else
      @diaries = current_user.diaries.order(id: :desc).page(params[:page])
      flash.now[:danger] = '記録の投稿に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @diary.update
      flash[:success] = 'ダイアリーを更新しました！'
      redirect_to diaries_user_path(current_user)
    else
      @diaries = current_user.diaries.order(id: :desc).page(params[:page])
      flash[:success] = 'ダイアリーの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @diary.destroy
    flash[:success] = 'ダイアリーを削除しました。'
    redirect_to diaries_user_path(current_user)
  end
  
  private
  
  def diary_params
    params.require(:diary).permit(:weight, :fat, :bmi, :muscle, :metabolism, :organsfat, :image)
  end
  
  def correct_user
    @diary = current_user.diaries.find_by(id: params[:id])
    unless @diary
      redirect_to user_path(@current_user)
    end
  end
end
