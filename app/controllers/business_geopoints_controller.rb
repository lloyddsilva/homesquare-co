class BusinessGeopointsController < ApplicationController
  before_action :set_business_geopoint, only: [:show, :edit, :update, :destroy]

  # GET /business_geopoints
  # GET /business_geopoints.json
  def index
    @business_geopoints = BusinessGeopoint.all
  end

  # GET /business_geopoints/1
  # GET /business_geopoints/1.json
  def show
  end

  # GET /business_geopoints/new
  def new
    @business_geopoint = BusinessGeopoint.new
  end

  # GET /business_geopoints/1/edit
  def edit
  end

  # POST /business_geopoints
  # POST /business_geopoints.json
  def create
    @business_geopoint = BusinessGeopoint.new(business_geopoint_params)

    respond_to do |format|
      if @business_geopoint.save
        format.html { redirect_to @business_geopoint, notice: 'Business geopoint was successfully created.' }
        format.json { render action: 'show', status: :created, location: @business_geopoint }
      else
        format.html { render action: 'new' }
        format.json { render json: @business_geopoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_geopoints/1
  # PATCH/PUT /business_geopoints/1.json
  def update
    respond_to do |format|
      if @business_geopoint.update(business_geopoint_params)
        format.html { redirect_to @business_geopoint, notice: 'Business geopoint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @business_geopoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_geopoints/1
  # DELETE /business_geopoints/1.json
  def destroy
    @business_geopoint.destroy
    respond_to do |format|
      format.html { redirect_to business_geopoints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_geopoint
      @business_geopoint = BusinessGeopoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_geopoint_params
      params.require(:business_geopoint).permit(:business_id, :geopoint_id)
    end
end
