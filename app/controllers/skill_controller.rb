class SkillController < ApplicationController
  def index
  	@skills = Skill.all
  end

  def show
  		@skill = Skill.find(params[:id])
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
  end

  def new
  end

  def edit
  	 @skill = Skill.find(params[:id])
  end

  def create
	  @skill = Skill.new(secure_params)
	  if @skill.save
	    redirect_to skill_index_path,   :notice => "Skill Created!"
	  else
	    redirect_to new_skill_path, :alert => "Unable to create Skill."
	  end
  end


  def destroy
	skill = Skill.find(params[:id])
	skill.destroy
	redirect_to skill_index_path, :notice => "Skill deleted."
  end


  def update
  	 @skill = Skill.find(params[:id])
    if @skill.update_attributes(secure_params)
      redirect_to skill_index_path, :notice => "Skill updated."
    else
      redirect_to skill_path, :alert => "Unable to update Skill."
    end
  end


  def secure_params
    params.require(:skill).permit(:name, :skill_type, :origin, :documentation, :description, :current_version, :release_date)
  end




end
