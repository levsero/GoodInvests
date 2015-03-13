class UsersController < ApplicationController
  before_action :require_signed_in!, except: [:new]
  before_action :correct_user, only: [:edit]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in!(@user)
      redirect_to root_url
    else
      session[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      session[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :session_token,
        :password, :job_title, :description, :picture)
  end

  def correct_user
    redirect_to users_url unless current_user.id == params[:id].to_i
  end
end
