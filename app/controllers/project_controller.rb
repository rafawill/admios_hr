class ProjectController < ApplicationController
  before_filter :authenticate_user!
  

  def index
  	@projects = Project.all
  end


  def new
     @project = Project.new
  end


  def create
	  @project = Project.new(secure_params)
    @project.client_id = params[:client_id]
	  if @project.save
	    redirect_to project_index_path, :notice => "Project Created!"
	  else
      render :action => 'new'
	  end
  end


  def edit
    @project = Project.find(params[:id])
  end


  def update
  	 @project = Project.find(params[:id])
     @project.client_id = params[:client_id]
    if @project.update_attributes(secure_params)
      redirect_to project_index_path, :notice => "Project updated."
    else
      render :action => 'edit'
    end
  end


  def destroy
	project = Project.find(params[:id])
	project.destroy
	redirect_to project_index_path, :notice => "Project deleted."
  end

  def developer_projects
    @developers = Person.all
    month_range =   Date.today.beginning_of_year..Date.today.end_of_year
    generate_month = month_range.map(&:beginning_of_month)
    @month_range = generate_month.map { |dates| dates.strftime("%b") }.uniq
    @total_billables = PersonHasProject.total_billables
    @total_projects = PersonHasProject.total_projected
    @total_bench = PersonHasProject.total_bench
  end  


  def secure_params
    params.require(:project).permit(:name, :description, :client_id, :start_date, :finish_date ,:website, :github)
  end


end
