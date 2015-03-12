module Api
  class UsersController < ApplicationController
    before_action :require_signed_in!, only: [:update]

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if correct_user && @user.update(user_params)
        render json: @user
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
      end
    end

    def logged_in
      if signed_in?
        @user = current_user
        render :current
      else
        render json: false
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :session_token,
          :password, :job_title, :description)
    end

    def correct_user
      current_user.id == params[:id].to_i
    end
  end
end
