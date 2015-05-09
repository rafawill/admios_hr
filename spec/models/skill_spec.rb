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

    context 'types' do
    	before :each do
    		@a = create(:skill, name: "A", skill_type: 0)
	    	@b = create(:skill, name: "B", skill_type: 1)
	    	@c = create(:skill, name: "C", skill_type: 2)
	    	@d = create(:skill, name: "D", skill_type: 3)
    	end
    	

	 	it "get languages type" do
	 		expect(Skill.languages).to eq([@a])
	 	end

	 	it "get framework type" do
	 		expect(Skill.framework).to eq([@b])
	 	end

	 	it "get database type" do
	 		expect(Skill.database).to eq([@c])
	 	end

	 	it "get mobile type" do
	 		expect(Skill.mobile).to eq([@d])
	 	end
    end
end	