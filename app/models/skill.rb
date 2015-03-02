class Skill < ActiveRecord::Base

 enum skill_type: ['Framework', 'Object Oriented', 'Data Base', 'Front-End', 'Back-End', 'Functional', 'Visual', 'Soft Skill']
 enum origin: ['Open Source', 'Unix', 'Microsoft', 'IBM', 'Apple', 'Sun']

 validates_presence_of :name, :skill_type, :origin, :documentation, :current_version, :release_date

end
