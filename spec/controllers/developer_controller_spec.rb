require 'rails_helper'


RSpec.describe DeveloperController, :type => :controller do 

 login_admin

	describe "GET #index" do
	  it "assigns @developers" do
	    developer = Person.all
	    get :index
	    expect(assigns(:developers)).to eq(developer)
	  end
	  
	  it "renders the :index view" do
	    get :index
	    expect(response).to render_template("index")
	  end	
	end


	describe "POST create" do
	    context "with valid attributes" do
		    it "creates a new developer" do
		      expect{
		        post :create, person: attributes_for(:person)
		      }.to change(Person,:count).by(1)
		      expect(flash[:notice]).to eq('Developer Created!')
		    end
		    
		    it "redirects to the new developer" do
		      post :create, person: attributes_for(:person)
		      expect(response.location).to redirect_to(developer_index_path)
		    end
	  end

	  context "with invalid attributes" do
		  	it "does not save the new developer" do
		      expect{
		        post :create, person: {:name => "Jhon", :last_name => "Doe" }
		      }.to_not change(Person,:count)
		    end
		    
		    it "re-renders the new method" do
		      post :create, person: {:name => "James", :last_name => "" }
		      expect(response).to render_template :new
		    end
	  end	
    end


	describe "Put Update" do
		before :each do
           @developer = create(:person, name: "Jhon", last_name: "Doe")
        end
		context "valid attributes" do
		    it "located the requested @developer" do
		      put :update, id: @developer, person: attributes_for(:person)
		      expect(assigns(:developer)).to eq(@developer)      
		    end
		  
		    it "changes @clients attributes" do
		      put :update, id: @developer, 
		        person: attributes_for(:person, name: "Mat", last_name: "Doe")
		      @developer.reload
		      expect(@developer.name).to eq("Mat")
		      expect(@developer.last_name).to eq("Doe")
		    end
		  
		    it "redirects to the updated developer" do
		      put :update, id: @developer, person: attributes_for(:person)
		      expect(flash[:notice]).to eq('Developer updated.') 
		      expect(response.location).to redirect_to(developer_index_path)
		    end
  		end


  		context "invalid attributes" do
		    it "locates the requested @developer" do
		      put :update, id: @developer, person: {:name =>""}
		      expect(assigns(:developer)).to eq(@developer)     
		    end
		    
		    it "does not change @developer attributes" do
		      put :update, id: @developer, 
		        person: attributes_for(:person, name: "Erick", last_name: nil)
		      @developer.reload
		      expect(@developer.name).to_not eq("Erick")
		      expect(@developer.last_name).to eq("Doe")
		    end
		    
		    it "re-renders the edit method" do
		      put :update, id: @developer, person: {:name =>""}
		      expect(response).to render_template(:edit)
		    end
		end
	end	

	describe 'DELETE Developer' do
		  before :each do
		    @developer = create(:person)
		  end
		  
		  it "deletes the developer" do
		    expect{
		      delete :destroy, id: @developer        
		    }.to change(Person,:count).by(-1)
		  end
		    
		  it "redirects to developer#index" do
		    delete :destroy, id: @developer
		    expect(flash[:notice]).to eq('Developer deleted.')
		    expect(response.location).to redirect_to(developer_index_path)
		  end
	end

end	