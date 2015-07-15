class ResidentsController < ApplicationController
  
  def index
  	
  	klass = [Neighborhood,Apartment].detect { |c| params["#{c.name.underscore}_id"] }
      
    if !klass.nil?
        @neighbors = klass.find(params["#{klass.name.underscore}_id"]).users.all
    end
  end

end
