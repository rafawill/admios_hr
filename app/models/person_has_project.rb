class PersonHasProject < ActiveRecord::Base
  belongs_to :person
  belongs_to :project

  validates_presence_of :note, :start_date, :project_id


def self.list_developer_projects(dev)
	PersonHasProject.where("person_id = ?" , dev)
end


def self.list_of_valid_projects(devs_object)
	not_in = []
	devs_object.each do |dev_project|
		not_in.push(dev_project.project_id)
	end
		
	unless not_in.first.blank?
	     Project.where.not('id in (?)', not_in )
	else
		 Project.all
	end
end


def self.current_projects(proj_object)
	current = []

	proj_object.each do |project|
		current.push(project) if project.current_project
	end
	current
end


end
