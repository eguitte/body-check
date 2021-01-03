class WorkoutsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @workout = Workout.new
  end

  def create
    @workout = current_user.workouts.build(workout_params)
    if @workout.save
      flash[:success] = '記録しました！'
      redirect_to workouts_user_path(current_user)
    else
      @workouts = current_user.workouts.order(id: :desc).page(params[:page])
      flash[:success] = '投稿に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def uodate
  end

  def destroy
  end
  
  def workout_params
    params.require(:workout).permit(:title, :content, :date)
  end
end
