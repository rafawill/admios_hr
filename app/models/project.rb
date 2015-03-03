class Project < ActiveRecord::Base
  belongs_to :client

  validates_presence_of :name, :description, :start_date, :website, :github

end
