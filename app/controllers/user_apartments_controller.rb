class UserApartmentsController < ApplicationController
  before_action :set_user_apartment, only: [:show, :edit, :update, :destroy]

  # GET /user_apartments
  # GET /user_apartments.json
  def index
    @user_apartments = UserApartment.all
  end

  # GET /user_apartments/1
  # GET /user_apartments/1.json
  def show
  end

  # GET /user_apartments/new
  def new
    @user_apartment = UserApartment.new
  end

  # GET /user_apartments/1/edit
  def edit
  end

  # POST /user_apartments
  # POST /user_apartments.json
  def create
    @user_apartment = UserApartment.new(user_apartment_params)

    respond_to do |format|
      if @user_apartment.save
        format.html { redirect_to @user_apartment, notice: 'User apartment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_apartment }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_apartments/1
  # PATCH/PUT /user_apartments/1.json
  def update
    respond_to do |format|
      if @user_apartment.update(user_apartment_params)
        format.html { redirect_to @user_apartment, notice: 'User apartment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_apartments/1
  # DELETE /user_apartments/1.json
  def destroy
    @user_apartment.destroy
    respond_to do |format|
      format.html { redirect_to user_apartments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_apartment
      @user_apartment = UserApartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_apartment_params
      params.require(:user_apartment).permit(:user_id, :apartment_id, :membership, :status)
    end
end
