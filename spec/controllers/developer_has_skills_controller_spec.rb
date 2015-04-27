require 'rails_helper'


RSpec.describe DeveloperHasSkillsController, :type => :controller do 

	login_admin
	
	before :each do
		create(:person_has_skill,:skill,:person)
		create(:person, name: "Jhon", last_name: "Doe")
	end

	describe "GET #index" do
	  it "assigns @developer_skills" do
	    developer_test = Person.first
	    get :index, :developer_id => developer_test.id
	    expect(assigns(:developer)).to eq(developer_test)
	    expect(assigns[:developer_skills].size).to eq 1
	  end
	  
	  it "renders the :index view" do
	  	developer_test = Person.first
	    get :index, :developer_id => developer_test.id
	    expect(response).to render_template("index")
	  end	
	end


	describe "GET #edit" do
	  it "renders the :edit view" do
		developer_test = Person.first
		developer_skill_test = PersonHasSkill.first
		get :edit, :developer_id => developer_test.id, :id => developer_skill_test.id
		expect(assigns(:developer)).to eq(developer_test)
		expect(assigns(:developer_skill)).to eq(developer_skill_test)
		expect(response).to render_template("edit")
	  end
    end


    describe "Get #new" do
    	it "render the :new view" do
    	  developer_test = Person.first
    	  get :new, :developer_id => developer_test.id
    	  expect(assigns(:developer)).to eq(developer_test)
    	  expect(response).to render_template("new")
        end
    end	

    describe "Post #create" do
      context "with valid attributes" do	
    	it "creates a new skill" do
    		developer_test = Person.first
		    expect{
		      post :create, person_has_skill: attributes_for(:person_has_skill,:skill,:person), :developer_id => developer_test.id
		    }.to change(PersonHasSkill,:count).by(1)
		    expect(flash[:notice]).to eq('Skill Association Created!')
		end

		it "redirects to the index developer skill" do
			developer_test = Person.first
		      post :create, person_has_skill: attributes_for(:person_has_skill,:skill,:person), :developer_id => developer_test.id
		      expect(response.location).to redirect_to(developer_developer_has_skills_path(developer_test))
		end
	  end

	  context "with invalid attributes" do
		  	it "does not save the new developer skill" do
		  	  developer_test = Person.first	
		      expect{
		        post :create, person_has_skill: {:notes => "lorem"}, :developer_id => developer_test.id
		      }.to_not change(PersonHasSkill,:count)
		    end
		    
		    it "re-renders the new method" do
		    	developer_test = Person.first	
		      post :create, person_has_skill: {:notes => "lorem"}, :developer_id => developer_test.id
		      expect(response.location).to render_template :new
		    end
	  end	
    end	

    describe "Put Update" do
		before :each do
           @person_has_skill = create(:person_has_skill,:skill,:person)
           @developer_test = Person.first
        end
		context "valid attributes" do
		    it "located the requested @person_has_skill" do
		      put :update, id: @person_has_skill, person_has_skill: attributes_for(:person_has_skill,:skill,:person), :developer_id => @developer_test.id
		      expect(assigns(:developer_skill)).to eq(@person_has_skill)      
		    end
		  
		    it "changes @person_has_skill attributes" do
		      put :update, id: @person_has_skill, 
		        person_has_skill: attributes_for(:person_has_skill,:skill,:person,note: "lorem lorem"), :developer_id => @developer_test.id
		      @person_has_skill.reload
		      expect(@person_has_skill.note).to eq("lorem lorem")
		    end
		  
		    it "redirects to the updated person_has_skill" do
		      put :update, id: @person_has_skill, person_has_skill: attributes_for(:person_has_skill,:skill,:person), :developer_id => @developer_test.id
		      expect(flash[:notice]).to eq('Skill Association updated.') 
		      expect(response.location).to redirect_to(developer_developer_has_skills_path(@developer_test))
		    end
  		end


  		context "invalid attributes" do
		    it "locates the requested @person_has_skill" do
		      put :update, id: @person_has_skill, person_has_skill: {:note =>""}, :developer_id => @developer_test.id
		      expect(assigns(:developer_skill)).to eq(@person_has_skill)     
		    end
		    
		    it "does not change @person_has_skill attributes" do
		      put :update, id: @person_has_skill, 
		        person_has_skill: attributes_for(:person_has_skill, note: nil), :developer_id => @developer_test.id
		      @person_has_skill.reload
		      expect(@person_has_skill.note).to_not eq(nil)
		    end
		    
		    it "re-renders the edit method" do
		      put :update, id: @person_has_skill, person_has_skill: {:note =>nil}, :developer_id => @developer_test.id
		      expect(response).to render_template(:edit)
		    end
		end
	end	

	describe 'DELETE person_has_skill' do
		  before :each do
		    @person_has_skill = create(:person_has_skill,:skill,:person)
		    @developer_test = Person.first
		  end
		  
		  it "deletes the person_has_skill" do
		    expect{
		      delete :destroy, id: @person_has_skill, :developer_id => @developer_test.id        
		    }.to change(PersonHasSkill,:count).by(-1)
		  end
		    
		  it "redirects to skill#index" do
		    delete :destroy, id: @person_has_skill, :developer_id => @developer_test.id
		    expect(flash[:notice]).to eq('Association deleted.')
		    expect(response.location).to redirect_to(developer_developer_has_skills_path(@developer_test))
		  end
	end

end	