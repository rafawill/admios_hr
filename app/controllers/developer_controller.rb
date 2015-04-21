class DeveloperController < ApplicationController
	before_filter :authenticate_user!


  def index
  	 @developers = Person.all
  end

  def new
     @developer = Person.new
  end


  def create
    @developer = Person.new(secure_params)
    if @developer.save
      redirect_to developer_index_path , :notice => "Developer Created!"
    else
      render :action => 'new'
    end
  end


  def edit
  	 @developer      = Person.find(params[:id])
	 @document_types = DocumentType.all
  end


  def update
  	 @developer = Person.find(params[:id])
    if @developer.update_attributes(secure_params)
      redirect_to developer_index_path, :notice => "Developer updated."
    else
      render :action => 'edit'
    end
  end


  def show
    @developer = Person.find(params[:id])
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end


  def destroy
  	developer = Person.find(params[:id])
  	developer.destroy
  	redirect_to developer_index_path, :notice => "Developer deleted."
  end


  def secure_params
    params.require(:person).permit(:name, :last_name, :email, :cel_number , :home_number,:address, :natioanlity, :document_type_id, :id_number, :birth_day, :nationality, :image)
  end


end
