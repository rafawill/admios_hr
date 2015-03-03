class ProjectController < ApplicationController
  def index
  	@projects = Project.all
  end

  def show
  	  @project = Project.find(params[:id])
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
  end

  def new
  end

  def edit
  	@project = Project.find(params[:id])
  end


  def create
	  @project = Project.new(secure_params)
    @project.client_id = params[:client_id]
	  if @project.save
	    redirect_to project_index_path   :notice => "Project Created!"
	  else
	    redirect_to new_project_path, :alert => "Unable to create Project."
	  end
  end


  def update
  	 @project = Project.find(params[:id])
     @project.client_id = params[:client_id]
    if @project.update_attributes(secure_params)
      redirect_to project_index_path, :notice => "Project updated."
    else
      redirect_to project_path, :alert => "Unable to update Project."
    end
  end


  def destroy
	project = Project.find(params[:id])
	project.destroy
	redirect_to project_index_path, :notice => "Project deleted."
  end


  def secure_params
    params.require(:project).permit(:name, :description, :client_id, :start_date, :finish_date ,:website, :github)
  end


end
