module Api
  class UsersController < ApplicationController
    before_action :require_signed_in!, only: [:update]

    def index
      page = User.page(params[:page])
      @page_info = {num_pages: page.total_pages, current: params[:page].to_i,
        num_items: page.total_count}
      @users = page
    end

    def create
      @user = User.new(user_params)

      if @user.save
        # AuthMailer.signup_email(@user).deliver
        # sign_in!(@user)
        render :show
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
      end
    end

    def show
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if correct_user && @user.update(user_params)
        render :show
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
      params.require(:user).permit(:email, :first_name, :last_name,
          :password, :job_title, :description, :picture)
    end

    def correct_user
      current_user.id == params[:id].to_i
    end
  end
end
