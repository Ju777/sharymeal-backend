require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should return the value pass in arg' do
    user = User.create(email:"rspec@mail.com", password:'123456')
    expect(user.email).to eq "rspec@mail.com"
  end
end
