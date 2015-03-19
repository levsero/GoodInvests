module Api
  class SessionsController < ApplicationController
    def create
      @user = User.find_by_credentials(params[:user])

      if @user
        sign_in!(@user)
        render :current
      else
        render json: "Invalid email/password combination", status: :unprocessable_entity
      end
    end

    def destroy
      sign_out!
      render json: { message: 'delete completed' }
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
