module Api
  class CommentsController < ApplicationController
    def create
      @comments = current_user.authored_comments.new(comment_params)

      if @comments.save
        render json: @comments
      else
        render json: @comments.errors.full_messages, status: :unprocessable_entity
      end
    end

    def update
      @comments = Comment.find(params[:id])

      if @comments.update(comment_params)
        render json: @comments
      else
        render json: @comments.errors.full_messages, status: :unprocessable_entity
      end
    end

    def destroy
    end

    def comment_params
      params.require(:comment).permit(:title, :body, :commentable_id,
          :commentable_type)
    end
  end
end
