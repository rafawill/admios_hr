class Project < ActiveRecord::Base

	validates_presence_of :name, :description, :start_date, :website, :github
end
