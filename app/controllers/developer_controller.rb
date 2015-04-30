class DeveloperController < ApplicationController
	before_filter :authenticate_user!


  def index
  	 @developers = Person.all
  end

  def new
     @developer = Person.new
  end


  def create
    @developer = Person.new(secure_params)
    if @developer.save
      redirect_to developer_index_path , :notice => "Developer Created!"
    else
      render :action => 'new'
    end
  end


  def edit
  	 @developer      = Person.find(params[:id])
	 @document_types = DocumentType.all
  end


  def update
  	 @developer = Person.find(params[:id])
    if @developer.update_attributes(secure_params)
      redirect_to developer_index_path, :notice => "Developer updated."
    else
      render :action => 'edit'
    end
  end


  def show
    @developer = Person.find(params[:id])
    @skill_language = Skill.languages
    @skill_framework = Skill.framework
    @skill_mobile = Skill.mobile
    @skill_database = Skill.database

    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def edit_skill
    @developer_skill = PersonHasSkill.find(params[:person_has_skill])
    @skill = Skill.find(params[:skill_id])
    @skill_language = case @skill[:skill_type].to_i
                   when 0
                      Skill.languages
                    when 1  
                      Skill.framework
                    when 2 
                      Skill.database
                    when 3
                      Skill.mobile
                   end               
    update_params = {rating: params[:rating]}
    if @developer_skill.update_attributes(update_params)
      respond_to do |format|
         format.js
      end
    end  
  end


  def edit_project
    @developer_project = PersonHasProject.find(params[:person_has_project_id])
    update_params = {start_date: params[:start_date], finish_date: params[:finish_date]}
    if @developer_project.update_attributes(update_params)
      respond_to do |format|
         format.js
      end
    end  
  end  

  def new_developer_skill
     @developer = Person.find(params[:id])
     developer_skills_list = PersonHasSkill.where('person_id = ?', params[:id])
     @developer_available_skills = Skill.where('id not in (?)', developer_skills_list.map(&:skill_id).empty? ? 0 :  developer_skills_list.map(&:skill_id))
     @developer_skill = PersonHasSkill.new
     respond_to do |format|
         format.js
     end
  end

  def new_developer_project
    @developer = Person.find(params[:id])
    @developer_projects = PersonHasProject.list_developer_projects(params[:id])
    @developer_available_projects = Project.where('id not in (?)', @developer_projects.map(&:project_id).empty? ? 0 : @developer_projects.map(&:project_id))
    @current_projects = @developer_projects.current_projects
    @developer_project = PersonHasProject.new
    respond_to do |format|
         format.js
     end
  end  

  def create_developer_skill
    update_secure = {rating: params[:rating], skill_id: params[:skill_id], note: params[:note], projects: params[:projects] } 
    @developer_skill = PersonHasSkill.new(update_secure)
    @skill = Skill.find(params[:skill_id])
    @developer_skill.person_id = params[:id]
    @developer = Person.find(params[:id])
    @person_skill_language = case @skill[:skill_type].to_i
                   when 0
                      @developer.person_language_skill
                    when 1  
                      @developer.person_framework_skill
                    when 2 
                      @developer.person_data_skill
                    when 3
                      @developer.person_mobile_skill
                   end
    if @developer_skill.save
        flash[:notice] = "Skill Association Created!"
    else

    end  
  end  

  def create_developer_project
    update_secure = {project_id: params[:project_id], start_date: params[:start_date], note: params[:note], finish_date: params[:finish_date], current_project: params[:current_project] } 
    @developer_project = PersonHasProject.new(update_secure)
    @developer_project.person_id = params[:id]
    @developer = Person.find(params[:id])
    if @developer_project.save
      flash[:notice] = "Project Association Created!"
    else

    end  
  end  

  def destroy
  	developer = Person.find(params[:id])
  	developer.destroy
  	redirect_to developer_index_path, :notice => "Developer deleted."
  end

  def delete_developer_skill
    developer_skill = PersonHasSkill.find(params[:person_has_skill])
    developer_skill.destroy
    flash[:notice] = "delete developer skill"
  end  

  def delete_developer_project
    developer_project = PersonHasProject.find(params[:person_has_project])
    developer_project.destroy
    flash[:notice] = "delete developer skill"
  end
    
  def secure_params
    params.require(:person).permit(:name, :last_name, :email, :cel_number , :home_number,:address, :country_id, :document_type_id, :id_number, :birth_day, :image)
  end


end
