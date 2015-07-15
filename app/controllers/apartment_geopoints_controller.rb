class ApartmentGeopointsController < ApplicationController
  before_action :set_apartment_geopoint, only: [:show, :edit, :update, :destroy]

  # GET /apartment_geopoints
  # GET /apartment_geopoints.json
  def index
    @apartment_geopoints = ApartmentGeopoint.all
  end

  # GET /apartment_geopoints/1
  # GET /apartment_geopoints/1.json
  def show
  end

  # GET /apartment_geopoints/new
  def new
    @apartment_geopoint = ApartmentGeopoint.new
  end

  # GET /apartment_geopoints/1/edit
  def edit
  end

  # POST /apartment_geopoints
  # POST /apartment_geopoints.json
  def create
    @apartment_geopoint = ApartmentGeopoint.new(apartment_geopoint_params)

    respond_to do |format|
      if @apartment_geopoint.save
        format.html { redirect_to @apartment_geopoint, notice: 'Apartment geopoint was successfully created.' }
        format.json { render action: 'show', status: :created, location: @apartment_geopoint }
      else
        format.html { render action: 'new' }
        format.json { render json: @apartment_geopoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartment_geopoints/1
  # PATCH/PUT /apartment_geopoints/1.json
  def update
    respond_to do |format|
      if @apartment_geopoint.update(apartment_geopoint_params)
        format.html { redirect_to @apartment_geopoint, notice: 'Apartment geopoint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @apartment_geopoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartment_geopoints/1
  # DELETE /apartment_geopoints/1.json
  def destroy
    @apartment_geopoint.destroy
    respond_to do |format|
      format.html { redirect_to apartment_geopoints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment_geopoint
      @apartment_geopoint = ApartmentGeopoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_geopoint_params
      params.require(:apartment_geopoint).permit(:apartment_id, :geopoint_id)
    end
end
