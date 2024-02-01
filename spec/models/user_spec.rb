require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_length_of(:password).is_at_least(6) }

  it { should have_many(:recipes) }

  describe '#name' do
    it 'returns the correct name' do
      expect(subject.name).to eq('Expected Name')
    end
  end
end
