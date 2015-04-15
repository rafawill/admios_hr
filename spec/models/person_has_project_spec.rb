require 'rails_helper'


describe PersonHasProject do

 context 'validation' do
 	subject{build(:person_has_project)} 
	it {should validate_presence_of(:note)}
	it {should validate_presence_of(:start_date)}
	it {should validate_presence_of(:project_id)}
 end

 context 'associate with' do
 	it { should belong_to(:project) }
 	it { should belong_to(:person) }
 end	


 context 'lists developer proyects ' do
 	 	 
 	it 'give id and get the developer' do
 		create(:person_has_project, project_id: 1, person_id: 1)
 		person_has_project = PersonHasProject.list_developer_projects(1)
 		expect(person_has_project.count).to eq(1)
 	end 	 
 end	

end	