class Project < ActiveRecord::Base
  belongs_to :client
  has_many :project_has_skills

  validates_presence_of :name, :description, :start_date, :website, :github

end
