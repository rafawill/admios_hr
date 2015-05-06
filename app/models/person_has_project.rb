class PersonHasProject < ActiveRecord::Base
  belongs_to :person
  belongs_to :project
  enum developer_condition: [:dev_placed, :dev_unbillable, :position_available_but_not_confirmed, :placed_but_not_billable ]

  validates_presence_of :note, :start_date, :project_id

  default_scope  { order(:finish_date => :desc) }

  scope :current_projects, -> {where(current_project: true)}


  def self.list_developer_projects(dev)
	PersonHasProject.where("person_id = ?" , dev)
  end

  def current_projects
	PersonHasProject.where("id = (?) AND current_project = (?)", self.id, true)
  end

  def self.total_billables
    date = DateTime.new(2015)
    start_month = date.beginning_of_month
    end_month = date.end_of_month
    person_has_project = {}
    (1..12).each do |month|
      person_has_project[start_month.strftime("%b")] = PersonHasProject.where("developer_condition = ? and ((start_date between ? and ?) or (start_date <= ? and finish_date >= ?) or (finish_date between ? and ?))",0,start_month,end_month,start_month,end_month,start_month,end_month).group("month(start_date),person_id").count.length
      start_month = start_month.next_month().beginning_of_month
      end_month = end_month.next_month().end_of_month
    end  
    person_has_project
  end


  def self.total_projected
    date = DateTime.new(2015)
    start_month = date.beginning_of_month
    end_month = date.end_of_month
    person_has_project = {}
    (1..12).each do |month|
      person_has_project[start_month.strftime("%b")]=  PersonHasProject.where("(developer_condition in (?) ) and ((start_date between ? and ?) or (start_date <= ? and finish_date >= ?) or (finish_date between ? and ?))",[0,2],start_month,end_month,start_month,end_month,start_month,end_month).group("month(start_date),person_id").count.length
      start_month = start_month.next_month().beginning_of_month
      end_month = end_month.next_month().end_of_month
    end  
    person_has_project
  end

  def self.total_bench
    date = DateTime.new(2015)
    start_month = date.beginning_of_month
    end_month = date.end_of_month
    person_has_project = {}
    (1..12).each do |month|
      person_has_project[start_month.strftime("%b")] = Person.count - PersonHasProject.where("developer_condition in (?)  and ((start_date between ? and ?) or (start_date <= ? and finish_date >= ?) or (finish_date between ? and ?))",[0,2],start_month,end_month,start_month,end_month,start_month,end_month).group("month(start_date),person_id").count.length  
      start_month = start_month.next_month().beginning_of_month
      end_month = end_month.next_month().end_of_month
    end  
    person_has_project
  end
end
