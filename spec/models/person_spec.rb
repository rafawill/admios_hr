require 'rails_helper'



describe Person do
 
 context 'validation' do
 	subject{build(:person)} 
 	it {should validate_presence_of(:name)}
 	it {should validate_presence_of(:last_name)}
 	it {should validate_presence_of(:email)}
 	it {should validate_presence_of(:cel_number)}
 	it {should validate_presence_of(:address)}
 	it {should validate_presence_of(:document_type_id)}
 	it {should validate_presence_of(:id_number)}
 	it {should validate_presence_of(:birth_day)}
 	it {should validate_presence_of(:country_id)}
 end	


 context 'associate' do

 	it { should have_many(:person_has_skills) }
 	it { should have_many(:person_has_projects) }

 end	

context 'full_name' do
 	subject(:person) {build(:person)} 
 	it { expect(person.full_name).to eq(person.name + " " + person.last_name) }
end

context 'could_add_skill' do

	context 'has all the available skills' do
		subject(:person) {create(:person_with_skills, skills_counts: 2)} 
 		it { expect(person.could_add_skill).to eq(false) }
 	end

 	context 'has some skills left' do
 		subject(:person) {create(:person_with_skills, skills_counts: 1)} 
 		subject {create(:skill)}

 		before :each do
    		create(:skill, name: "A", skill_type: 0)
    	end

 		it { expect(person.could_add_skill).to eq(true) }
 	end
end

context 'skills' do

	context 'has language skills' do
		subject(:person) {create(:person_with_language_skill)} 
 		it { expect(person.person_language_skill.count).to  eq(1) }
 		it { expect(person.person_framework_skill.count).to eq(0) }
 		it { expect(person.person_data_skill.count).to      eq(0) }
 		it { expect(person.person_mobile_skill.count).to    eq(0) }
 	end

 	context 'has framework skills' do
		subject(:person) {create(:person_with_framework_skill)} 
 		it { expect(person.person_language_skill.count).to  eq(0) }
 		it { expect(person.person_framework_skill.count).to eq(1) }
 		it { expect(person.person_data_skill.count).to      eq(0) }
 		it { expect(person.person_mobile_skill.count).to    eq(0) }
 	end

 	context 'has data skills' do
		subject(:person) {create(:person_with_data_skill)} 
 		it { expect(person.person_language_skill.count).to  eq(0) }
 		it { expect(person.person_framework_skill.count).to eq(0) }
 		it { expect(person.person_data_skill.count).to      eq(1) }
 		it { expect(person.person_mobile_skill.count).to    eq(0) }
 	end

 	context 'has mobile skills' do
		subject(:person) {create(:person_with_mobile_skill)} 
 		it { expect(person.person_language_skill.count).to  eq(0) }
 		it { expect(person.person_framework_skill.count).to eq(0) }
 		it { expect(person.person_data_skill.count).to      eq(0) }
 		it { expect(person.person_mobile_skill.count).to    eq(1) }
 	end
end


end	