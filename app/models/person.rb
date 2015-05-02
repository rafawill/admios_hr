class Person < ActiveRecord::Base

 belongs_to :document_type
 belongs_to :country

 has_many :person_has_skills
 has_many :person_has_projects

 has_many :skill, through: :person_has_skills

 validates_presence_of :name, :last_name, :email, :cel_number , :address, :id_number, :birth_day, :document_type_id, :country_id




  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :small => "50x50>" },
                      :url  => "/assets/developer/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/assets/developer/:id/:style/:basename.:extension"

  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/jpg'] 


  def person_skills(ids)
  	 self.skill.select('skills.*, person_has_skills.*').where('skills.id in (?)',ids).order('person_has_skills.rating desc')
  end

  def full_name
  	self.name + ' ' + self.last_name
  end

  def person_language_skill
  	self.skill.where('skill_type = ?',0).order('person_has_skills.rating desc')
  end	

  def person_framework_skill
  	self.skill.where('skill_type = ?',1).order('person_has_skills.rating desc')
  end

  def person_data_skill
  	self.skill.where('skill_type = ?',2).order('person_has_skills.rating desc')
  end	

  def person_mobile_skill
  	self.skill.where('skill_type = ?',3).order('person_has_skills.rating desc')
  end

end
