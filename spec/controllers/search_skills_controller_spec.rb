require 'rails_helper'


RSpec.describe SearchSkillsController, :type => :controller do 

 login_admin

	describe "GET #index" do
	  it "assigns @skill" do
	    skill = Skill.all
	    get :index
	    expect(assigns(:skills)).to eq(skill)
	  end
	  
	  it "renders the :index view" do
	    get :index
	    expect(response).to render_template("index")
	  end	
	end

	describe "Post search" do

		before :each do
			3.times do 
				create(:person_has_skill,:skill,:person)
			end	
		end
			
		it "search and get the PersonHasSkill object" do
			ids = PersonHasSkill.all.map(&:skill_id)
			post :search ,:id => ids, :format => 'js'
			person_skill = PersonHasSkill.get_person_skill(ids)
			expect(person_skill.length).to eq(3)
		end	

	end	
end	