require 'rails_helper'


describe Skill do

	context 'validation' do
	 	subject{build(:skill)} 
	 	it {should validate_presence_of(:name)}
	 	it {should validate_presence_of(:skill_type)}
	 	it {should validate_presence_of(:origin)}
	 	it {should validate_presence_of(:documentation)}
	 	it {should validate_presence_of(:current_version)}
	 	it {should validate_presence_of(:release_date)}
    end

    context 'associate' do

	 	it { should have_many(:person_has_skills) }
	 	it { should have_many(:project_has_skills) }
    end
end	