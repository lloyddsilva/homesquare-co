class GeopointsController < ApplicationController
  before_action :set_geopoint, only: [:show, :edit, :update, :destroy]

  # GET /geopoints
  # GET /geopoints.json
  def index
    @geopoints = Geopoint.all
  end

  # GET /geopoints/1
  # GET /geopoints/1.json
  def show
  end

  # GET /geopoints/new
  def new
    @geopoint = Geopoint.new
  end

  # GET /geopoints/1/edit
  def edit
  end

  # POST /geopoints
  # POST /geopoints.json
  def create
    @geopoint = Geopoint.new(geopoint_params)

    respond_to do |format|
      if @geopoint.save
        format.html { redirect_to @geopoint, notice: 'Geopoint was successfully created.' }
        format.json { render action: 'show', status: :created, location: @geopoint }
      else
        format.html { render action: 'new' }
        format.json { render json: @geopoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geopoints/1
  # PATCH/PUT /geopoints/1.json
  def update
    respond_to do |format|
      if @geopoint.update(geopoint_params)
        format.html { redirect_to @geopoint, notice: 'Geopoint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @geopoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geopoints/1
  # DELETE /geopoints/1.json
  def destroy
    @geopoint.destroy
    respond_to do |format|
      format.html { redirect_to geopoints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geopoint
      @geopoint = Geopoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def geopoint_params
      params.require(:geopoint).permit(:address, :street_name, :block_number, :postal_code, :latitude, :longitude)
    end
end
