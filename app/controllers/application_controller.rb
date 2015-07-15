class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  #############
  ## FILTERS ##
  #############
  
  # Sets instance variables for @neighborhood based on params
  def set_neighborhood
    @neighborhood ||= current_user.apartments.first.neighborhood
    render(:template => "errors/error_404", :status => 404) if @neighborhood.blank?
  end

  # Sets instance variables for @apartment based on params
  def set_apartment
    @apartment ||= current_user.apartments.first
    render(:template => "errors/error_404", :status => 404) if @apartment.blank?
  end

end
