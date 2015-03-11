module Api
  class UsersController < ApplicationController
    def index
      @users = User.all
    end

    def show
      @User = User.find(params[:id])
    end
  end
end
