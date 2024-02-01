require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  before do
    @user1 = User.create!(name: 'user 1', email: 'user1@gmail.com', password: '123456')
    @user2 = User.create!(name: 'user 2', email: 'user2@gmail.com', password: '123456')
  end
  describe 'User model' do
    it 'should dispaly user name' do
      expect(@user1.name).to eq('user 1')
      expect(@user2.name).to eq('user 2')
    end

    it 'should dispaly user email' do
      expect(@user1.email).to eq('user1@gmail.com')
      expect(@user2.email).to eq('user2@gmail.com')
    end

    it 'is not valid without email' do
      @user1.email = nil
      expect(@user1).to_not be_valid
    end

    it 'is not valid using password less than 6 characters' do
      @user1.password = '1234'
      expect(@user1).to_not be_valid
    end
  end

  it { should have_many(:recipes) }

  describe '#name' do
    it 'returns the correct name' do
      expect(subject.name).to eq('Expected Name')
    end
  end
end
