class DeveloperController < ApplicationController
	before_filter :authenticate_user!
  def index
  	 @developers = Person.all
  end

  def show
	@developer = Person.find(params[:id])
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
  end

  def create
  #	binding.pry


      # if resource.active_for_authentication?
      #   set_flash_message :notice, :signed_up if is_flashing_format?
      #   sign_up(resource_name, resource)
      #   respond_with resource, location: after_sign_up_path_for(resource)
      # else
      #   set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
      #   expire_data_after_sign_in!
      #   respond_with resource, location: after_inactive_sign_up_path_for(resource)
      # end


	  @developer = Person.new(secure_params)
	  if @developer.save
	    flash[:success] = "Developer Created!"
	    redirect_to root_path
	  else
	  	#render :action => :index
	    redirect_to developer_index_path, :alert => "Unable to create Developer."
	  end

  end

    def secure_params
    params.require(:person).permit(:name, )
  end


end
