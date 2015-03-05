class DeveloperHasSkillsController < ApplicationController
  before_filter :authenticate_user!

  def index
  	 @developer = Person.find(params[:developer_id])
     @developer_skills = PersonHasSkill.list_developer_skills(params[:developer_id])
     @developer_assigned_skills = PersonHasSkill.list_of_valid_skills(@developer_skills)
  end

  def edit
     @developer = Person.find(params[:developer_id])
     @developer_skill = PersonHasSkill.find(params[:id])
  end

  def new
     @developer = Person.find(params[:developer_id])
     @developer_skills_list = PersonHasSkill.list_developer_skills(params[:developer_id])
     @developer_assigned_skills = PersonHasSkill.list_of_valid_skills(@developer_skills_list)
     @developer_skill = PersonHasSkill.new
  end

  def show
  end

  def create
    @developer_skill.person_id = params[:developer_id]
    if @developer_skill.save
      redirect_to developer_developer_has_skills_path,   :notice => "Skill Association Created!"
    else
      @developer_skill = PersonHasSkill.new(secure_params)
      @developer = Person.find(params[:developer_id])
      @developer_skills_list = PersonHasSkill.list_developer_skills(params[:developer_id])
      @developer_assigned_skills = PersonHasSkill.list_of_valid_skills(@developer_skills_list)
      render :action => 'new'
    end
  end


  def update
     @developer_skill = PersonHasSkill.find(params[:id])
    if @developer_skill.update_attributes(secure_params)
      redirect_to developer_developer_has_skills_path, :notice => "Skill Association updated."
    else
      @developer = Person.find(params[:developer_id])
      render :action => 'edit'
    end
  end


  def destroy
    developer_skill = PersonHasSkill.find(params[:id])
    developer_skill.destroy
    redirect_to developer_developer_has_skills_path, :notice => "Association deleted."
  end


  def secure_params
    params.require(:person_has_skill).permit(:person_id, :skill_id, :rating, :projects, :note)
  end


end
