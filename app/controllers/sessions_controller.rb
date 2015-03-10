class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(params[:user])

    if @user
      sign_in!(@user)
      redirect_to root_url
    else
      session[:errors] = ["Invalid email/password combination"]
      render :new
    end
  end

  def destroy
    sign_out!
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
