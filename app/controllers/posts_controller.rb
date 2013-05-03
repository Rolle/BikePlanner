class PostsController < ApplicationController

  before_filter :authenticate, :only => [:create, :new, :update, :destroy]
  
  def index
    @page_id = "post_index"
    @posts = Post.all(:order => "created_at desc")
  end

  def show
    @page_id = "post_show"
    @post = Post.find(params[:id])
  end

  def new
    @page_id = "post_new"
    @post = Post.new
  end

  def edit
    @page_id = "post_edit"
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, :notice => 'Neuer Eintrag wurde gespeichert.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, :notice => 'Eintrag wurde gespeichert.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text,:link)
  end
end
