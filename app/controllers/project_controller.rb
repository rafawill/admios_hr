class ProjectController < ApplicationController
  def index
  	@projects = Project.all
  end

  def show
  end

  def new
  end

  def edit
  end


  def create
	  @project = Project.new(secure_params)
	  if @project.save
	    flash[:success] = "Project Created!"
	    redirect_to project_index_path
	  else
	    redirect_to new_project_path, :alert => "Unable to create Project."
	  end
  end


  def secure_params
    params.require(:project).permit(:name, :description, :start_date, :finish_date ,:website, :github)
  end


end
