class DeveloperHasSkillsController < ApplicationController
  before_filter :authenticate_user!


  def index
  	 @developer = Person.find(params[:developer_id])
     @developer_skills = PersonHasSkill.list_developer_skills(params[:developer_id])
     @developer_assigned_skills = PersonHasSkill.list_of_valid_skills(@developer_skills)
     

  end

  def edit
     @developer = Person.find(params[:developer_id])
     @developer_has_skills = PersonHasSkill.find(params[:id])

  end

  def new
     @developer = Person.find(params[:developer_id])
     @developer_skills = PersonHasSkill.list_developer_skills(params[:developer_id])
     @developer_assigned_skills = PersonHasSkill.list_of_valid_skills(@developer_skills)


  end

  def show
  end

  def create
    @developer_skill = PersonHasSkill.new(secure_params)
    @developer_skill.person_id = params[:developer_id]
    if @developer_skill.save
      redirect_to developer_developer_has_skills_path,   :notice => "Skill Association Created!"
    else
      redirect_to new_developer_developer_has_skill_path, :alert => "Unable to Associate Skill."
    end
  end


  def update
     @developer_skill = PersonHasSkill.find(params[:id])
    if @developer_skill.update_attributes(secure_params)
      redirect_to developer_developer_has_skills_path, :notice => "Skill Association updated."
    else
      redirect_to new_developer_developer_has_skill_path, :alert => "Unable to update Association."
    end
  end


  def destroy
    developer_skill = PersonHasSkill.find(params[:id])
    developer_skill.destroy
    redirect_to developer_developer_has_skills_path, :notice => "Association deleted."
  end



  def secure_params
    params.require(:developer_has_skills).permit(:person_id, :skill_id, :rating, :projects, :note)
  end


end
