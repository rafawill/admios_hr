class DeveloperHasProjectsController < ApplicationController
   before_filter :authenticate_user!
   before_action :set_current_project, only:[:update, :create]

  def index
  	 @developer = Person.find(params[:developer_id])
     @developer_projects = PersonHasProject.list_developer_projects(params[:developer_id])
     @developer_available_projects = Project.where('id not in (?)', @developer_projects.map(&:project_id).nil? ? @developer_projects.map(&:project_id) : 0)
     @current_projects = @developer_projects.current_projects
  end

  def edit
     @developer = Person.find(params[:developer_id])
     @developer_project = PersonHasProject.find(params[:id])
  end

  def new
     @developer = Person.find(params[:developer_id])
     @developer_projects = PersonHasProject.list_developer_projects(params[:developer_id])
     @developer_available_projects = Project.where('id not in (?)', @developer_projects.map(&:project_id).nil? ? @developer_projects.map(&:project_id) : 0)
     @current_projects = @developer_projects.current_projects
     redirect_to developer_developer_has_projects_path,   :alert => "Developer has too many projects" if @current_projects.length >= 3
     @developer_project = PersonHasProject.new
  end


  def create
    @developer_project = PersonHasProject.new(secure_params)
    @developer_project.person_id = params[:developer_id]
    if @developer_project.save
      redirect_to developer_developer_has_projects_path,   :notice => "Project Association Created!"
    else
      @developer = Person.find(params[:developer_id])
      @developer_projects_list = PersonHasProject.list_developer_projects(params[:developer_id])
      @developer_available_projects = Project.where('id not in (?)', @developer_projects.map(&:project_id).nil? ? @developer_projects.map(&:project_id) : 0)
      render :action => 'new'
    end
  end

  def update
     @developer_project = PersonHasProject.find(params[:id])
     @current_projects = @developer_project.current_projects

     if @current_projects.length >= 3
        if !@developer_project.current_project && secure_params[:current_project].eql?("1")
          @developer = Person.find(params[:developer_id])
          redirect_to edit_developer_developer_has_project_path(@developer_project.person_id, @developer_project), 
          :alert => "The developer has too many Projects." and return
        end
     end 
 

    if @developer_project.update_attributes(secure_params) 
      redirect_to developer_developer_has_projects_path, :notice => "Skill Association updated."
    else
      @developer = Person.find(params[:developer_id])
      render :action => 'edit'
    end


  end

  def show
  end


  def destroy
    project_project = PersonHasProject.find(params[:id])
    project_project.destroy
    redirect_to developer_developer_has_projects_path, :notice => "Association deleted."
  end

  def secure_params
    params.require(:person_has_project).permit(:person_id, :project_id, :start_date, :finish_date, :note, :current_project, :developer_condition)
  end  

end
