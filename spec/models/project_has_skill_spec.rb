require 'rails_helper'


describe ProjectHasSkill do

 context 'validation' do
 	subject{build(:project_has_skill)} 
	it {should validate_presence_of(:note)}
 end

context 'associate with' do
 	it { should belong_to(:project) }
 	it { should belong_to(:skill) }
 end	


 context 'lists project skill ' do
 	 	 
 	it 'give id and get projects lists' do
 		create(:project_has_skill, project_id: 1, skill_id: 1)
 		person_has_project = ProjectHasSkill.list_project_skills(1)
 		expect(person_has_project.count).to eq(1)
 	end 	 
 end
end	
