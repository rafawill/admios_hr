require 'rails_helper'


RSpec.describe ProjectController, :type => :controller do 

 login_admin

	describe "GET #index" do
	  it "assigns @project" do
	    project = Project.all
	    get :index
	    expect(assigns(:projects)).to eq(project)
	  end
	  
	  it "renders the :index view" do
	    get :index
	    expect(response).to render_template("index")
	  end	
	end


	describe "POST create" do
	    context "with valid attributes" do
		    it "creates a new project" do
		      expect{
		        post :create, project: attributes_for(:project)
		      }.to change(Project,:count).by(1)
		      expect(flash[:notice]).to eq('Project Created!')
		    end
		    
		    it "redirects to the new project" do
		      post :create, project: attributes_for(:project)
		      expect(response.location).to redirect_to(project_index_path)
		    end
	  end

	  context "with invalid attributes" do
		  	it "does not save the new project" do
		      expect{
		        post :create, project: {:name => "Admios"}
		      }.to_not change(Project,:count)
		    end
		    
		    it "re-renders the new method" do
		      post :create, project: {:name => "Admios"}
		      expect(response).to render_template :new
		    end
	  end	
    end


	describe "Put Update" do
		before :each do
           @project = create(:project, name: "Admios")
        end
		context "valid attributes" do
		    it "located the requested @project" do
		      put :update, id: @project, project: attributes_for(:project)
		      expect(assigns(:project)).to eq(@project)      
		    end
		  
		    it "changes @project attributes" do
		      put :update, id: @project, 
		        project: attributes_for(:project, name: "Project 1")
		      @project.reload
		      expect(@project.name).to eq("Project 1")
		    end
		  
		    it "redirects to the updated project" do
		      put :update, id: @project, project: attributes_for(:project)
		      expect(flash[:notice]).to eq('Project updated.') 
		      expect(response.location).to redirect_to(project_index_path)
		    end
  		end


  		context "invalid attributes" do
		    it "locates the requested @project" do
		      put :update, id: @project, project: {:name =>""}
		      expect(assigns(:project)).to eq(@project)     
		    end
		    
		    it "does not change @project attributes" do
		      put :update, id: @project, 
		        project: attributes_for(:project, name: "Admios Client", description: nil)
		      @project.reload
		      expect(@project.name).to_not eq("Admios Client")
		      expect(@project.description).to eq("MyText")
		    end
		    
		    it "re-renders the edit method" do
		      put :update, id: @project, project: {:name =>""}
		      expect(response).to render_template(:edit)
		    end
		end
	end	

	describe 'DELETE project' do
		  before :each do
		    @project = create(:project)
		  end
		  
		  it "deletes the project" do
		    expect{
		      delete :destroy, id: @project        
		    }.to change(Project,:count).by(-1)
		  end
		    
		  it "redirects to project#index" do
		    delete :destroy, id: @project
		    expect(flash[:notice]).to eq('Project deleted.')
		    expect(response.location).to redirect_to(project_index_path)
		  end
	end

end	