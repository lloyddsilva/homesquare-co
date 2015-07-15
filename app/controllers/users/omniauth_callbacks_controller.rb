class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  rescue_from ActiveRecord::RecordInvalid do |exception|
    logger.error exception
    redirect_to root_path, :notice => 'An error occurred while signing up from Facebook. Please sign up with your email address instead.'
  end

  rescue_from ActiveRecord::AssociationTypeMismatch do |exception|
    logger.error exception
    redirect_to root_path, :notice => 'Please enter your address below and click - Join your neighborhood'
  end

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
     if !session["apartment_id"].blank?
         logger.debug "DEBUG::Has Location in Session::#{params.inspect}::#{session["apartment_id"]}"
         @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], session["apartment_id"])
    else
         logger.debug "DEBUG::Does Not Have Location::#{params.inspect}::#{session["apartment_id"]}"

         @user_email = request.env["omniauth.auth"].info.email unless request.env["omniauth.auth"].blank?
         
         if User.find_by_email(@user_email)
            @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
         else
            (redirect_to (root_path), :notice => 'Please enter your address below and click - Join your neighborhood')
            return
         end
    end

    logger.debug "DEBUG::Params::#{params.inspect}"

    if @user.persisted? 
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end