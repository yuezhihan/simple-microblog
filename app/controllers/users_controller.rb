class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    render 'new'
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params);
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App."
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

【部门群】
1. 请各位部长尽快建立部门群，并安排假期学习任务（可以根据每个人的情况给予学习建议，也可统一安排小任务）。
2. 各位部长负责想方设法活跃群内气氛，并与新同学建立革命友谊。
3. 如果不介意的话，请把我和hr @周金梦 拉进部门群。




end
