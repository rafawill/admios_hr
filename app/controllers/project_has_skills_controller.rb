class ProjectHasSkillsController < ApplicationController
  before_filter :authenticate_user!

  def index
  	 @project = Project.find(params[:project_id])
     @project_skills = ProjectHasSkill.list_project_skills(params[:project_id])
     @project_assigned_skills = ProjectHasSkill.list_of_valid_skills(@project_skills)
  end


  def edit
     @project = Project.find(params[:project_id])
     @project_skill = ProjectHasSkill.find(params[:id])

  end

  def new
     @project = Project.find(params[:project_id])
     @project_skills_list = ProjectHasSkill.list_project_skills(params[:project_id])
     @project_assigned_skills = ProjectHasSkill.list_of_valid_skills(@project_skills_list)
     @project_skill = ProjectHasSkill.new
  end

  def show
  end

  def create
    @project_skill = ProjectHasSkill.new(secure_params)
    @project_skill.project_id = params[:project_id]
    if @project_skill.save
      redirect_to project_project_has_skills_path,   :notice => "Skill Association Created!"
    else
      @project = Project.find(params[:project_id])
      @project_skills_list = ProjectHasSkill.list_project_skills(params[:project_id])
      @project_assigned_skills = ProjectHasSkill.list_of_valid_skills(@project_skills_list)
      render :action => 'new'
    end
  end

  def update
     @project_skill = ProjectHasSkill.find(params[:id])
    if @project_skill.update_attributes(secure_params)
      redirect_to project_project_has_skills_path, :notice => "Skill Association updated."
    else
      @project = Project.find(params[:project_id])
      render :action => 'edit'
    end
  end


  def destroy
    project_skill = ProjectHasSkill.find(params[:id])
    project_skill.destroy
    redirect_to project_project_has_skills_path, :notice => "Association deleted."
  end



  def secure_params
    params.require(:project_has_skill).permit(:project_id, :skill_id, :note)
  end

end
