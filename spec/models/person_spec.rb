require 'rails_helper'



describe Person do
 
 context 'validation' do
 	subject{build(:person)} 
 	it {should validate_presence_of(:name)}
 	it {should validate_presence_of(:last_name)}
 	it {should validate_presence_of(:email)}
 	it {should validate_presence_of(:cel_number)}
 	it {should validate_presence_of(:address)}
 	it {should validate_presence_of(:id_type)}
 	it {should validate_presence_of(:id_number)}
 	it {should validate_presence_of(:birth_day)}
 	it {should validate_presence_of(:nationality)}
 end	


 context 'associate' do

 	it { should have_many(:person_has_skills) }
 	it { should have_many(:person_has_projects) }

 end	

end	