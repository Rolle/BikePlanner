class CommentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :new, :update, :destroy, :create_main]
  
  respond_to :html, :js

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save!
    @tour = Tour.find(@comment.tour_id)
    @new_comment = Comment.new
  end
  
  def withouttour
    @comment = Comment.new()
    @comment.comment = params[:single_comment]    
    @comment.user_id = current_user.id
    @comment.save!
    @last_comments = Comment.all(:limit => 5, :order => "created_at DESC")    
  end

  def show
    @tour = Tour.find(params[:id])
  	#@ratings = Rating.where('tour_id = ?', params[:id])
    respond_with @comments#, :location => ratings_url
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :tour_id)
  end
end
