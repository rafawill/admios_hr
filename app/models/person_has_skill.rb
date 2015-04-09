class PersonHasSkill < ActiveRecord::Base
  belongs_to :person
  belongs_to :skill

  enum skill_rating: ['never touched it', 'read about it and used it privately', 'learning, using it in a current project', 'completed 1 project with it', 'completed 2-3 projects with it', 'completed more than 3 projects']
  
  validates_presence_of :note

	def self.list_developer_skills(dev)
		PersonHasSkill.where("person_id = ?" , dev)
	end

	def self.list_of_valid_skills(devs_object)
		not_in = []
		devs_object.each do |dev_skill|
			not_in.push(dev_skill.skill_id)
		end
			
		unless not_in.first.blank?
		     Skill.where.not('id in (?)', not_in )
		else
			 Skill.all
		end
	end

	def self.get_person_skill(ids)
		skill_relationships = PersonHasSkill.joins(:person,:skill).where('skill_id in (?)', ids).order("rating desc")
		person_skill = skill_relationships.group_by(&:person)
		person_skill
	end	

end
