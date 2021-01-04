class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followings, :followers, :diaries, :workouts]
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy, :followings, :followers, :diaries]
  before_action :correct_user, only: [:destroy, :update, :edit]
  
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(5)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '登録しました!'
      redirect_to @user
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :new
    end
  end
    
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "マイページを更新しました！"
      redirect_to @user
    else
      flash.now[:danger] = "マイページの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "退会しました。"
    redirect_to root_path
  end
    
  def followings
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def diaries
    @diaries = @user.diaries.order(id: :desc).page(params[:page]).per(5)
  end
  
  def workouts
    @workouts = @user.workouts.order(id: :desc).page(params[:page]).per(25)
  end
      
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :profile)
  end
  
  def correct_user
    unless current_user == @user 
      redirect_to user_path(@current_user)
    end
  end
  
end
  
  
  
