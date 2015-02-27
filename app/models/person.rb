class Person < ActiveRecord::Base
 enum id_type: ['National ID', 'Passport', 'Other']
 
 enum countries: ['Argentina','Brasil','Bolivia', 'Colombia','Honduras','Panama','Venezuela']


 validates_presence_of :name, :last_name, :email, :cel_number , :address, :id_type, :id_number, :birth_day, :nationality

end
