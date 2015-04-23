class SearchSkillsController < ApplicationController
    before_filter :authenticate_user!

	def index
		@skills = Skill.all
	end	
	
	def search
		unless  params[:id].blank? 
			ids = params[:id]
			@person_skill = PersonHasSkill.get_person_skill(ids)
		else
			@person_skill = []
		end	

		respond_to do |format|
		       format.js
		end
     
    end		
end
