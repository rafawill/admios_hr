require 'rails_helper'


RSpec.describe SkillController, :type => :controller do 

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


	describe "POST create" do
	    context "with valid attributes" do
		    it "creates a new skill" do
		      expect{
		        post :create, skill: attributes_for(:skill)
		      }.to change(Skill,:count).by(1)
		      expect(flash[:notice]).to eq('Skill Created!')
		    end
		    
		    it "redirects to the index skill" do
		      post :create, skill: attributes_for(:skill)
		      expect(response.location).to redirect_to(skill_index_path)
		    end
	  end

	  context "with invalid attributes" do
		  	it "does not save the new skill" do
		      expect{
		        post :create, skill: {:name => "Clojure"}
		      }.to_not change(Skill,:count)
		    end
		    
		    it "re-renders the new method" do
		      post :create, skill: {:name => "Clojure"}
		      expect(response).to render_template :new
		    end
	  end	
    end


	describe "Put Update" do
		before :each do
           @skill = create(:skill, name: "Clojure")
        end
		context "valid attributes" do
		    it "located the requested @skill" do
		      put :update, id: @skill, skill: attributes_for(:skill)
		      expect(assigns(:skill)).to eq(@skill)      
		    end
		  
		    it "changes @skill attributes" do
		      put :update, id: @skill, 
		        skill: attributes_for(:skill, name: "iOS")
		      @skill.reload
		      expect(@skill.name).to eq("iOS")
		    end
		  
		    it "redirects to the updated skill" do
		      put :update, id: @skill, skill: attributes_for(:skill)
		      expect(flash[:notice]).to eq('Skill updated.') 
		      expect(response.location).to redirect_to(skill_index_path)
		    end
  		end


  		context "invalid attributes" do
		    it "locates the requested @skill" do
		      put :update, id: @skill, skill: {:name =>""}
		      expect(assigns(:skill)).to eq(@skill)     
		    end
		    
		    it "does not change @skill attributes" do
		      put :update, id: @skill, 
		        skill: attributes_for(:skill, name: "My Sql", documentation: nil)
		      @skill.reload
		      expect(@skill.name).to_not eq("My Sql")
		      expect(@skill.documentation).to eq("MyString")
		    end
		    
		    it "re-renders the edit method" do
		      put :update, id: @skill, skill: {:name =>""}
		      expect(response).to render_template(:edit)
		    end
		end
	end	

	describe 'DELETE skill' do
		  before :each do
		    @skill = create(:skill)
		  end
		  
		  it "deletes the skill" do
		    expect{
		      delete :destroy, id: @skill        
		    }.to change(Skill,:count).by(-1)
		  end
		    
		  it "redirects to skill#index" do
		    delete :destroy, id: @skill
		    expect(flash[:notice]).to eq('Skill deleted.')
		    expect(response.location).to redirect_to(skill_index_path)
		  end
	end

end	