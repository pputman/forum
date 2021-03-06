class ForumThreadsController < ApplicationController
  before_filter :login_required
  
  # GET /forum_threads
  # GET /forum_threads.json
  def index
    @category = Category.find(params[:category_id])
    @forum_threads = @category.forum_threads

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forum_threads }
    end
  end

  # GET /forum_threads/1
  # GET /forum_threads/1.json
  def show
    @forum_thread = ForumThread.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum_thread }
    end
  end

  # GET /forum_threads/new
  # GET /forum_threads/new.json
  def new
    @category = Category.find(params[:category_id])
    @forum_thread = @current_user.forum_threads.build
    @forum_thread.posts.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum_thread }
    end
  end

  # GET /forum_threads/1/edit
  def edit
    @forum_thread = ForumThread.find(params[:id])
  end

  # POST /forum_threads
  # POST /forum_threads.json
  def create
    @forum_thread = @current_user.forum_threads.build(params[:forum_thread])
    @forum_thread.category = Category.find(params[:category_id])
    @forum_thread.posts.first.user = @current_user
    respond_to do |format|
      if @forum_thread.save
        format.html { redirect_to @forum_thread, notice: 'Forum thread was successfully created.' }
        format.json { render json: @forum_thread, status: :created, location: @forum_thread }
      else
        format.html { render action: "new" }
        format.json { render json: @forum_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forum_threads/1
  # PUT /forum_threads/1.json
  def update
    @forum_thread = ForumThread.find(params[:id])

    respond_to do |format|
      if @forum_thread.update_attributes(params[:forum_thread])
        format.html { redirect_to @forum_thread, notice: 'Forum thread was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_threads/1
  # DELETE /forum_threads/1.json
  def destroy
    @forum_thread = ForumThread.find(params[:id])
    @forum_thread.destroy

    respond_to do |format|
      format.html { redirect_to forum_threads_url }
      format.json { head :ok }
    end
  end
end
