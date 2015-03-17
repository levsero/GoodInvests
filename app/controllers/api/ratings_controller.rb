module Api
  class RatingsController < ApplicationController
    # ensuring sign-in and correct user is implicit in the methods

    def create
      @rating = current_user.rated_objects.
        where("rateable_id = ? AND rateable_type = ?", params[:rating]["rateable_id"],
        params[:rating]["rateable_type"]).first

      if @rating
        @rating.rating = params[:rating]["rating"]
      else
        @rating = current_user.rated_objects.new(ratings_params)
      end

      if @rating.save
        render json: @rating
      else
        render json: @rating.errors.full_messages, status: :unprocessable_entity
      end
    end

    private

    def ratings_params
      params.require(:rating).permit(:rating, :rateable_id, :rateable_type)
    end

  end
end
