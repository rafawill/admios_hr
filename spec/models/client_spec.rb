require 'rails_helper'


describe Client do

	context 'testing validations' do

		it "should require a name" do
          client = Client.new(name: nil)
          client.valid?
          expect(client.errors[:name]).to include("can't be blank")
        end

        it "describe is require" do
          client = Client.new(description: nil)
          client.valid?
          expect(client.errors[:description]).to include("can't be blank")
        end	
	end	

	context "has relationships with project" do

		it { should have_many(:projects) }
    end
end	