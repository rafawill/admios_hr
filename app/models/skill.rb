class Skill < ActiveRecord::Base
 has_many :person_has_skills
 has_many :project_has_skills

 has_many :person, through: :person_has_skills

 enum skill_type: %w(Languages Frameworks Data Mobile)
 enum origin: ['Open Source', 'Unix', 'Microsoft', 'IBM', 'Apple', 'Sun']

 validates_presence_of :name, :skill_type, :origin, :documentation, :current_version, :release_date

 def self.get_person_skill(ids)
		#PersonHasSkill.joins(:skill,:person).where('skill_id in (?)', ids ).select("people.last_name")
		#skill = Skill.joins(:person_has_skills,:person).where('skills.id in (?)', ids )
		@skill.person.where('id in (?)', ids)
		@skill
	end

 def self.languages	
 	where('skill_type= ?', 0)
 end

 def self.framework
  	where('skill_type = ?',1)
  end

  def self.database
  	where('skill_type = ?',2)
  end	

  def self.mobile
  	where('skill_type = ?',3)
  end

end
