class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :load_eventable

  # GET /events
  # GET /events.json
  def index
    @events = @eventable.events.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @posts = @eventable.posts
    @post = Post.new
  end

  # GET /events/new
  def new
    @event = @eventable.events.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = @eventable.events.new(event_params)
    @event.owner = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to [@eventable, :events], notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = @eventable.events.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to [@eventable, :events], notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end


  def change_status
    invite_status = UserEvent.where(:user_id => current_user.id, :event_id => params[:id]).first

    if invite_status
      invite_status.destroy
    end

    UserEvent.create!(:user_id => current_user.id, :event_id => params[:id], :status => params[:status])

    respond_to do |format|
      format.json { render :json => { :nothing => :true }, :status => 200 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :alias, :slug, :venue, :event_date, :start_time, :end_time, :owner_id, :neighborhood_id)
    end

  def load_eventable
      # logger.debug "DEBUG::#{params.inspect}"
      klass = [Neighborhood,Apartment].detect { |c| params["#{c.name.underscore}_id"] }
      
      if !klass.nil?
        @eventable = klass.find(params["#{klass.name.underscore}_id"])
      else
        @eventable = current_user.location.neighborhood
      end
    end
end
