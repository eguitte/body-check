class WorkoutsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update]
  
  def show
    @workout = Workout.find(params[:id])
  end
     
  
  def new
    @workout = Workout.new
  end

  def create
    @workout = current_user.workouts.build(workout_params)
    if @workout.save
      redirect_to workouts_user_path(current_user)
    else
      @workouts = current_user.workouts.order(id: :desc).page(params[:page])
      flash[:success] = '投稿に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @workout.update(workout_params)
      flash[:success] = '更新しました！'
      redirect_to workouts_user_path(current_user)
    else
      @workouts = current_user.workouts.order(id: :desc).page(params[:page])
      flash[:success] = '更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @workout.destroy
    flash[:success] = 'ワークアウト記録を削除しました。'
    redirect_to workouts_user_path(current_user)
  end 
  
  private
  
  def workout_params
    params.require(:workout).permit(:title, :content, :start_time)
  end
  
  def correct_user
    @workout = current_user.workouts.find_by(id: params[:id])
    unless @workout
      redirect_to user_path(current_user)
    end
  end
end
