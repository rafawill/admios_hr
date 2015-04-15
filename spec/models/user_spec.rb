require 'rails_helper'

describe User do

  context 'validations' do
 	subject{build(:user)} 
	it {should validate_presence_of(:name)}
	it {should validate_presence_of(:last_name)}
	it {should validate_presence_of(:address)}
	it {should validate_presence_of(:phone)}
	it {should validate_presence_of(:cell_phone)}
	it {should validate_presence_of(:image)}
  end	

end
