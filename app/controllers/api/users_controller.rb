module Api
  class UsersController < ApplicationController
    before_action :require_signed_in!, only: [:update]

    def index
      @current_user = current_user
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
      @current_user = current_user
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

    def password_reset_request
      user = User.find_by_email(params[:email])

      if user
        msg = UserMailer.password_reset(user)
        msg.deliver
        render json: {}, status: :ok
      else
        render json: {}, status: :ok
      end
    end

    def password_reset_url
      user = User.find_by_email(params[:email])
      if user && user.session_token == params[:token]
        redirect_to "/#password_reset/#{params[:token]}/#{user.id}"
      else
        render json: params, status: :unprocessable_entity
      end
    end

    def password_reset
      user = User.find(params[:id])

      if user.session_token == params[:token]
        user.password = params[:password]
        if params[:password].length < 6
          render json: "password too short, minimum 6 characters", status: :unprocessable_entity
        elsif  user.save
          render json: {}, status: :ok
          user.reset_session_token!
        else
          render json: user.errors.full_messages, status: :unprocessable_entity
        end
      else
        render json: params, status: 404
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
