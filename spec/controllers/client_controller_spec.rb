require 'rails_helper'


RSpec.describe ClientController, :type => :controller do 

 login_admin

	describe "GET #index" do
	  it "assigns @clients" do
	    client = Client.all
	    get :index
	    expect(assigns(:clients)).to eq(client)
	  end
	  
	  it "renders the :index view" do
	    get :index
	    expect(response).to render_template("index")
	  end	
	end


	describe "POST create" do
	    context "with valid attributes" do
		    it "creates a new client" do
		      expect{
		        post :create, client: attributes_for(:client)
		      }.to change(Client,:count).by(1)
		      expect(flash[:notice]).to eq('Client Created!')
		    end
		    
		    it "redirects to the new client" do
		      post :create, client: attributes_for(:client)
		      expect(response.location).to redirect_to(client_index_path)
		    end
	  end

	  context "with invalid attributes" do
		  	it "does not save the new client" do
		      expect{
		        post :create, client: {:name => "string"}
		      }.to_not change(Client,:count)
		    end
		    
		    it "re-renders the new method" do
		      post :create, client: {:name => "string"}
		      expect(response).to render_template :new
		    end
	  end	
    end


	describe "Put Update" do
		before :each do
           @client = create(:client, name: "admios Hr", description: "Human Resourse")
        end
		context "valid attributes" do
		    it "located the requested @client" do
		      put :update, id: @client, client: attributes_for(:client)
		      expect(assigns(:client)).to eq(@client)      
		    end
		  
		    it "changes @clients attributes" do
		      put :update, id: @client, 
		        client: attributes_for(:client, name: "Project 1", description: "Lorem lorem")
		      @client.reload
		      expect(@client.name).to eq("Project 1")
		      expect(@client.description).to eq("Lorem lorem")
		    end
		  
		    it "redirects to the updated client" do
		      put :update, id: @client, client: attributes_for(:client)
		      expect(flash[:notice]).to eq('Client updated.') 
		      expect(response.location).to redirect_to(client_index_path)
		    end
  		end


  		context "invalid attributes" do
		    it "locates the requested @client" do
		      put :update, id: @client, client: {:name =>""}
		      expect(assigns(:client)).to eq(@client)     
		    end
		    
		    it "does not change @client attributes" do
		      put :update, id: @client, 
		        client: attributes_for(:client, name: "Admios HR", description: nil)
		      @client.reload
		      expect(@client.name).to_not eq("Admios HR")
		      expect(@client.description).to eq("Human Resourse")
		    end
		    
		    it "re-renders the edit method" do
		      put :update, id: @client, client: {:name =>""}
		      expect(response).to render_template(:edit)
		    end
		end
	end	

	describe 'DELETE Client' do
		  before :each do
		    @client = create(:client)
		  end
		  
		  it "deletes the client" do
		    expect{
		      delete :destroy, id: @client        
		    }.to change(Client,:count).by(-1)
		  end
		    
		  it "redirects to client#index" do
		    delete :destroy, id: @client
		    expect(flash[:notice]).to eq('Client deleted.')
		    expect(response.location).to redirect_to(client_index_path)
		  end
	end

end	