module Api
  class FollowsController < ApplicationController
    # ensuring sign-in and correct user is implicit in the methods
    
    def create
      @follow = current_user.follows.new(follows_params)

      if @follow.save
        render json: @follow
      else
        render json: @follow.errors.full_messages, status: :unprocessable_entity
      end
    end

    def destroy
      @follow = current_user.follows.
        where("followable_id = ? AND followable_type = ?", params[:followable_id],
        params[:followable_type]).first

      @follow.destroy
      render json: {follows: "destroy"}
    end

    private

    def follows_params
      params.require(:follow).permit(:follower_id, :followable_id, :followable_type)
    end

  end
end
