class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_filter :load_groupable

  # GET /groups
  # GET /groups.json
  def index
    @groups = @groupable.groups.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @posts = @groupable.posts
    @post = Post.new
  end

  # GET /groups/new
  def new
      @group = @groupable.groups.new
      @group.visibility = 'Public'
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = @groupable.groups.new(group_params)
    @group.owner = current_user

    respond_to do |format|
      if @group.save
        format.html { redirect_to [@groupable, :groups], notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @group = @groupable.groups.find(params[:id])
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to [@groupable, :groups], notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :alias, :slug, :neighborhood_id, :visibility, :owner_id)
    end

    def load_groupable
      # logger.debug "DEBUG::#{params.inspect}"
      klass = [Neighborhood,Apartment].detect { |c| params["#{c.name.underscore}_id"] }
      
      if !klass.nil?
        @groupable = klass.find(params["#{klass.name.underscore}_id"])
      else
        @groupable = current_user.apartments.first.neighborhood
      end
    end
end
