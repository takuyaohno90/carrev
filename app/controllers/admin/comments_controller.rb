class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    comment = Comment.find(params[:id])
    id = comment.review.id
    comment.destroy
    redirect_to review_path(id)
  end

end
