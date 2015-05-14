class DeveloperController < ApplicationController
	before_filter :authenticate_user!
  before_action :set_current_project, only:[:create_developer_project, :edit_project]


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
      
      respond_to do |format|
        format.html{redirect_to developer_index_path, :notice => "Developer updated."}
        format.json { render json: @developer }
      end
    else
      respond_to do |format|
        format.html {render :action => 'edit'}
        format.json { render json: @developer.errors, :status => 500 }
      end
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
    respond_to do |format|
        format.html {render :action => :show}
        format.pdf { 
          render pdf: "developer_profile",template:'developer/developer_profile.pdf.erb',show_as_html: params[:debug]
        }
      end
  end

  def developer_profile
    
    @developer = Person.find(params[:id])
    unless params[:rating].empty?
    
    @person_language_skill = @developer.person_language_skill.where('rating >= ?', params[:rating])
    @person_framework_skill = @developer.person_framework_skill.where('rating >= ?', params[:rating])
    @person_data_skill = @developer.person_data_skill.where('rating >= ?', params[:rating])
    @person_mobile_skill = @developer.person_mobile_skill.where('rating >= ?', params[:rating])
    else
    @person_language_skill = @developer.person_language_skill
    @person_framework_skill = @developer.person_framework_skill
    @person_data_skill = @developer.person_data_skill
    @person_mobile_skill = @developer.person_mobile_skill
    end 

    unless params[:start_date].empty?
      @developer_project =  @developer.person_has_projects.where('start_date >= ? ',params[:start_date])
      else
      @developer_project =  @developer.person_has_projects  
    end
    
    
    respond_to do |format|
      format.pdf { 
             render pdf: "#{@developer.full_name}_profile",
             disposition: 'attachment',
             template:'developer/developer_profile.pdf.erb',
             save_to_file: Rails.root.join('public/assets/pdf', "#{@developer.full_name}_profile.pdf")
             
      }
    end  
  end  


  def edit_skill
    @developer_skill = PersonHasSkill.find(params[:person_has_skill_id])
    @skill = Skill.find(params[:person_has_skill][:skill_id])
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
    if @developer_skill.update_attributes(secure_params_developer_skill)
      respond_to do |format|
         format.js
      end
    end  
  end


  def edit_project
    @developer_project = PersonHasProject.find(params[:person_has_project_id])
    if @developer_project.update_attributes(secure_params_developer_project)
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
    @developer_skill = PersonHasSkill.new(secure_params_developer_skill)
    @skill = Skill.find(params[:person_has_skill][:skill_id])
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
        flash.now[:notice] = "Skill Association Created!"
    else
     render :json => @developer_skill.errors, :status => 500
    end  
  end  

  def create_developer_project
    @developer_project = PersonHasProject.new(secure_params_developer_project)
    @developer_project.person_id = params[:id]
    @developer = Person.find(params[:id])
    if @developer_project.save
      flash.now[:notice] = "Project Association Created!"
    else
      render :json => @developer_project.errors, :status => 500
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
  end  

  def delete_developer_project
    developer_project = PersonHasProject.find(params[:person_has_project])
    developer_project.destroy
  end
    
  private
  def secure_params
    params.require(:person).permit(:name, :last_name, :email, :cel_number , :home_number,:address, :country_id, :document_type_id, :id_number, :birth_day, :image, :skype)
  end

  def secure_params_developer_skill
    params.require(:person_has_skill).permit(:person_id, :skill_id, :rating, :projects, :note)
  end
  
  def secure_params_developer_project
    params.require(:person_has_project).permit(:person_id, :project_id, :start_date, :finish_date, :note, :current_project, :developer_condition)
  end  

end
