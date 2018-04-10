class PostsController < ApplicationController
  #ensures user is logged in to create or delete anything
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  #creates post, and if successfull, goes to post
  def create
    @post = Post.new(post_params);

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    find_post
  end

  def edit
    find_post
  end

  #allows user to edit post, then redirects to updated post
  def update
    find_post

    if @post.update(params[:post].permit(:title, :body))
      redirect_to @post
    else
      render 'edit'
    end
  end

  #deletes post, comments are deleted with post
  def destroy
    find_post
    @post.destroy
    redirect_to root_path
  end

  #finds posts by id, modularized due to frequent use
  private
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def find_post
      @post = Post.find(params[:id])
    end
end
