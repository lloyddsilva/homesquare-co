class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :load_postable

  # GET /posts
  # GET /posts.json
  def index
    if !@postable.nil?
      @posts = @postable.posts.order('created_at desc').page(params[:page]).per_page(10)
      logger.debug "DEBUG::#{post_params}"
      @post = @postable.posts.new
    else
      redirect_to user_path(current_user)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    if @postable
      @post = @postable.posts.new
    else
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
    @post = @postable.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    if @postable
      @post = @postable.posts.new(post_params)
      @post.user_id = current_user.id
    else
      @post = Post.new(post_params)
      @post.user_id = current_user.id
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to [@postable, :posts], notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = @postable.posts.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to [@postable, :posts], notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.fetch(:post, {}).permit(:title, :content, :post_category_id, :user_id, :postable_id, :postable_type, :attached_document)
    end

    def load_postable
      # logger.debug "DEBUG::#{params.inspect}"
      klass = [Neighborhood,Apartment,Event,Group].detect { |c| params["#{c.name.underscore}_id"] }
      
      if !klass.nil?
        @postable = klass.find(params["#{klass.name.underscore}_id"])
      else
        if !current_user.apartments.first.nil?
          @postable = current_user.apartments.first.neighborhood
        else
          @postable = nil
        end
      end
    end
end
