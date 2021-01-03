class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy, :followings, :followers, :diaries]
  before_action :correct_user, only: [:destroy, :update, :edit]
  
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def diaries
    @user = User.find(params[:id])
    @diaries = @user.diaries.order(id: :desc).page(params[:page]).per(5)
  end
  
  def workouts
    @user = User.find(params[:id])
    @workouts = @user.workouts.order(id: :desc).page(params[:page])
  end
      
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :profile)
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user 
      redirect_to user_path(@current_user)
    end
  end
  
end
