class PersonHasSkill < ActiveRecord::Base
  belongs_to :person
  belongs_to :skill



# def list_developer_skills(dev)
# 	PersonHasSkill.where()
# end


end
