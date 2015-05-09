require 'rails_helper'

describe PersonHasSkill do

 context 'validation' do
 	subject{build(:person_has_skill)} 
	it {should validate_presence_of(:note)}
 end

 context 'associate with' do
 	it { should belong_to(:skill) }
 	it { should belong_to(:person) }
 end	


 context 'lists developer skills ' do
 	before(:each) do
    	create(:person_has_skill,:skill,:person)
    end
    
 	it 'give id and get the developer' do
 		create(:person_has_skill,:skill,:person)
 		person_has_skill = PersonHasSkill.get_person_skill(PersonHasSkill.all.map(&:skill_id))
 		expect(person_has_skill.length).to eq(2)
 	end 	 
 end	

end	
