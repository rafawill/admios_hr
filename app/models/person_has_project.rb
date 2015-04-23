class PersonHasProject < ActiveRecord::Base
  belongs_to :person
  belongs_to :project

  validates_presence_of :note, :start_date, :project_id

  scope :current_projects, -> {where(current_project: true)}


  def self.list_developer_projects(dev)
	PersonHasProject.where("person_id = ?" , dev)
  end

  def current_projects
	PersonHasProject.where("id = (?) AND current_project = (?)", self.id, true)
  end

end
