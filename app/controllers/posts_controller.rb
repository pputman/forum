class PostsController < ApplicationController
  before_filter :login_required
  
  # GET /posts
  # GET /posts.json
  def index
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @posts = @forum_thread.posts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    #@post = Post.new
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @post = @current_user.posts.build
    #@post.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = @current_user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @post = @forum_thread.posts.build(params[:post])
    @post.user = @current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @forum_thread, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = @current_user.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post.forum_thread, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
end
