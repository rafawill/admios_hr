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

  def could_add_skill
    total_skill = Skill.all.count
    total_person_skill = self.person_has_skills.count
    return false if total_skill == total_person_skill
    return true if total_person_skill < total_skill
  end

  def developer_in_project
    date = DateTime.new(2015)
    start_month = date.beginning_of_month
    end_month = date.end_of_month
    new_data_arr = []
    person_has_project = {}
    (1..12).each do |month|
      person_has_project[start_month.strftime("%b")] = self.person_has_projects.where(" ((start_date between ? and ?) or (start_date <= ? and finish_date >= ?) or (finish_date between ? and ?))", start_month, end_month, start_month, end_month, start_month, end_month).group("month(start_date)")
      start_month = start_month.next_month().beginning_of_month
      end_month = end_month.next_month().end_of_month
    end 
    person_has_project
  end  

end
