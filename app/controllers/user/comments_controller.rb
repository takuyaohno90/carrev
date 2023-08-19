class User::CommentsController < ApplicationController

  def create
    review = Review.find(params[:review_id]) #params[:review_id]は5になっていた
    comment = current_user.comments.new(comment_params)
    comment.review_id = review.id
    comment.save
    redirect_to user_review_path(review.id)
  end

  def destroy
    comment = Comment.find(params[:id])
    id = comment.review.id
    comment.destroy
    redirect_to user_review_path(id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
