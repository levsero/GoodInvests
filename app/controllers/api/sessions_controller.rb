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

    def omniauth
      p auth_hash
      user = User.find_or_create_by_auth_hash(auth_hash)
      sign_in!(user)
      redirect_to root_url
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
