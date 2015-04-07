class SearchSkillsController < ApplicationController
    before_filter :authenticate_user!

	def index
		@skills = Skill.all
	end	
	
	def search
		if params[:id] 
			ids = params[:id]
			#skill = PersonHasSkill.where('skill_id IN (?)',ids.map(&:to_i)) 
			#@person_skill = Person.where('id In (?)',skill.map(&:id))
			@person_skill = PersonHasSkill.get_person_skill(ids)
			 respond_to do |format|
		       format.js
		     end
		end	
     
    end		
end
