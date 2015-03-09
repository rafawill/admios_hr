class Project < ActiveRecord::Base
  belongs_to :client
  has_many :project_has_skills
  has_many :person_has_projects

  validates_presence_of :name, :description, :start_date, :website, :github

end
