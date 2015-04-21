class SkillController < ApplicationController
  before_filter :authenticate_user!
  

  def index
  	@skills = Skill.all
  end


  def new
    @skill = Skill.new
  end


  def create
    @skill = Skill.new(secure_params)
    if @skill.save
      redirect_to skill_index_path,   :notice => "Skill Created!"
    else
      render :action => 'new'
    end
  end


  def edit
     @skill = Skill.find(params[:id])
  end

  def update
     @skill = Skill.find(params[:id])
    if @skill.update_attributes(secure_params)
      redirect_to skill_index_path, :notice => "Skill updated."
    else
      render :action => 'edit'
    end
  end

  def show
  end


  def destroy
	skill = Skill.find(params[:id])
	skill.destroy
	redirect_to skill_index_path, :notice => "Skill deleted."
  end





  def secure_params
    params.require(:skill).permit(:name, :skill_type, :origin, :documentation, :description, :current_version, :release_date)
  end




end
