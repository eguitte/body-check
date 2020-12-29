class DiariesController < ApplicationController
  before_action :require_user_logged_in
  
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
  end

  def delete
  end
  
  private
  
  def diary_params
    params.require(:diary).permit(:weight, :fat, :bmi, :muscle, :metabolism, :organsfat, :image)
  end
end
