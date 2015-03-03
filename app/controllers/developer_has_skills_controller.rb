class DeveloperHasSkillsController < ApplicationController
  before_filter :authenticate_user!


  def index
  	 @developer = Person.find(params[:developer_id])
     @developer_skills = PersonHasSkill.where("person_id = ?" , params[:developer_id])
  end

  def edit
  end

  def new
     @developer = Person.find(params[:developer_id])
     @skills = Skill.all
  end

  def show
  end
end
