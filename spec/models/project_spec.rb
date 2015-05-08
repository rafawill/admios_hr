require 'rails_helper'

describe Project do

	context 'validation' do
	 	subject{build(:project)} 
	 	it {should validate_presence_of(:name)}
	 	it {should validate_presence_of(:description)}
	 	it {should validate_presence_of(:start_date)}
	 	it {should validate_presence_of(:website)}
	 	it {should validate_presence_of(:github)}
    end

    context 'association with' do
	 	it { should have_many(:project_has_skills) }
	 	it { should have_many(:person_has_projects) }
	 	it { should belong_to(:client) }
    end
end	
