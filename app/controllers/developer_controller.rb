class DeveloperController < ApplicationController
	before_filter :authenticate_user!
 

  def index
  	 @developers = Person.all
  end


  def edit
  	 @person = Person.find(params[:id])
  end



  def update
  	 @developer = Person.find(params[:id])
    if @developer.update_attributes(secure_params)
      redirect_to developer_index_path, :notice => "Developer updated."
    else
      redirect_to developer_path, :alert => "Unable to update Developer."
    end
  end




  def show
	@developer = Person.find(params[:id])
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
  end


  def destroy
	person = Person.find(params[:id])
	person.destroy
	redirect_to developer_index_path, :notice => "Developer deleted."
  end



  def new

  end


  def create
	  @developer = Person.new(secure_params)
	  if @developer.save
	    redirect_to developer_index_path , :notice => "Developer Created!"
	  else
	    redirect_to new_developer_path, :alert => "Unable to create Developer."
	  end
  end



  def secure_params
    params.require(:person).permit(:name, :last_name, :email, :cel_number , :home_number,:address, :natioanlity ,:id_type, :id_number, :birth_day, :nationality, :image)
  end


end
