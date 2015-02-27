class Person < ActiveRecord::Base
 enum id_type: ['National ID', 'Passport', 'Other']

 validates_presence_of :name, :last_name, :email, :cel_number , :address, :id_type, :id_number, :birth_day

end
