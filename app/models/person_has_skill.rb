class PersonHasSkill < ActiveRecord::Base
  belongs_to :person
  belongs_to :skill

  enum skill_rating: ['never touched it', 'read about it and used it privately', 'learning, using it in a current project', 'completed 1 project with it', 'completed 2-3 projects with it', 'completed more than 3 projects']
  
  validates_presence_of :note

	def self.get_person_skill(ids)
		skill_relationships = PersonHasSkill.joins(:person,:skill).where('skill_id in (?)', ids).order("rating desc")
		person_skill = skill_relationships.group_by(&:person)
		person_skill
	end	

	def self.total_skill
		Skill.all.count
	end	
end
