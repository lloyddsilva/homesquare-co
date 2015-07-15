class RegistrationsController < Devise::RegistrationsController
	before_filter :update_sanitized_params, if: :devise_controller?


	def update_sanitized_params
        logger.debug "DEBUG::Params::#{params.inspect}"
        devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :location_id, :postal_code, :unit_number, :terms_of_service)}
        devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :birthday, :gender, :location_id, :postal_code, :unit_number, :avatar, :about_me, :resident_since, :home_town, :education, :occupation, :interests, :fav_thing_neighborhood, :fav_thing_apartment, :fav_restaurant, :fav_hangout)}
    end
   

  # GET /resource/sign_up
  def new
      logger.debug "DEBUG::Params::#{params.inspect}"
        if !params[:lookup].blank?
            @lookup_location = params[:lookup][:address]
            logger.debug "DEBUG::lookup_location::#{@lookup_location}"
        end

        if !@lookup_location.blank?
          @user_location = Geopoint.find_or_create_by(address: @lookup_location)
          session[:apartment_id] = @user_location.apartments.first.id
          build_resource({})
          respond_with self.resource
      else
          redirect_to root_path, :notice => 'Please enter your address below and click - Join your neighborhood'
      end
  end  

  def update
    # For Rails 4
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, account_update_params)
      @user.update_with_password(account_update_params)
    else
      account_update_params.delete(:password)
      account_update_params.delete(:password_confirmation)
      account_update_params.delete(:current_password)
      @user.update_without_password(account_update_params)
    end

  
  if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
  else
      render "edit"
  end
end

  private

  # check if we need password to update user data
  def needs_password?(user, params)
    user.provider.blank?
  end

end
