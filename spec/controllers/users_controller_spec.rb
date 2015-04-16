require 'rails_helper'


RSpec.describe UsersController, :type => :controller do 

 login_admin
 
 context "sigin admin user" do

  it "should have a current_user" do
    expect(subject.current_user).to_not be_nil
  end

  it "should be admin" do
  	expect(subject.current_user.role).to eq("admin")
  end	
 end

 describe "GET #index" do
  it "assigns @users" do
    user = User.all
    get :index
    expect(assigns(:users)).to eq(user)
  end
  
  it "renders the :index view" do
    get :index
    expect(response).to render_template("index")
  end	
 end

 describe "GET #show" do

  it "assigns the requested user to @user" do
    user = create(:user)
    get :show, id: user
    expect(assigns(:user)).to eq(user)
  end
  
  it "renders the #show view" do
    get :show, id: create(:user)
    expect(response).to render_template("show")
  end

 end

 describe 'PUT update' do

  before :each do
    @user = create(:user, name: "Beautiful", last_name: "Test")
  end

  context "valid attributes" do
    it "located the requested @user" do
      put :update, id: @user, user: attributes_for(:user)
      expect(assigns(:user)).to eq(@user)      
    end
  
    it "changes @user attributes" do
      put :update, id: @user,  user: attributes_for(:user, role: 'developer')
      @user.reload
      expect(@user.role).to eq('developer')
    end
  
    it "status 302" do
      put :update, id: @user, user: attributes_for(:user)
      expect(response.status).to eq(302)
    end
  end

 end	

	
end