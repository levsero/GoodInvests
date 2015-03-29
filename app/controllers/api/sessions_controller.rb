module Api
  class SessionsController < ApplicationController
    def create
      @user = User.find_by_credentials(params[:user])

      if @user
        # make sure guest user always has 5 unread emails
        if @user == User.find_by_email("testing@gmail.com")
          if @user.notifications.unread.count < 5
            @user.notifications.read.order("Random()").limit(5).update_all(is_read: false)
          end
        end
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
