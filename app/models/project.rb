class Project < ActiveRecord::Base
  belongs_to :client
  has_many :project_has_skills
  has_many :person_has_projects

  validates_presence_of :name, :description, :start_date, :website, :github

  scope :c_project, -> {where(:finish_date, nil).empty? ? true : false}

  def current_project
  	  Project.where("id = (?) AND finish_date = (?)",self.id, nil).empty? ? true : false
  end


end
