class ProjectHasSkill < ActiveRecord::Base
  belongs_to :project
  belongs_to :skill
  
  validates_presence_of :note

	def self.list_project_skills(proj)
		ProjectHasSkill.where("project_id = ?" , proj)
	end

	def self.list_of_valid_skills(proj_object)
		not_in = []
		proj_object.each do |dev_skill|
			not_in.push(dev_skill.skill_id)
		end
			
		unless not_in.first.blank?
		     Skill.where.not('id in (?)', not_in )
		else
			 Skill.all
		end
	end

end
