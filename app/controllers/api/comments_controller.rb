module Api
  class CommentsController < ApplicationController
    before_action :require_signed_in!, only: [:create]

    def create
      @comment = current_user.authored_comments.new(comment_params)

      if @comment.save
        render :show
      else
        render json: @comment.errors.full_messages, status: :unprocessable_entity
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

    def owns_comment
      if !current_user.comments.include(@comment)
        render json: "User does not match", status: 404
      end
    end

  end
end
