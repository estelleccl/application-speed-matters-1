require 'rails_helper'

describe Point do
  it { is_expected.to belong_to(:user) }

  describe '#valid?' do
    it { is_expected.to validate_presence_of(:user) }

    it { is_expected.to validate_presence_of(:label) }

    # it { should validate_numericality_of(:value).only_integer } #weirddd shoulda matchers error? https://github.com/thoughtbot/shoulda-matchers/issues/784
    it { is_expected.to allow_value(0).for(:value) }
    it { is_expected.to allow_value(1).for(:value) }
    it { is_expected.to_not allow_value(-1).for(:value) }
  end

  describe '#save' do
    let(:user) { create(:user) }

    it "increments the user's total_points by the value of the point" do
      expect {
        create(:point, :user => user, :value => 10)
      }.to change(user, :total_points).by(10)
    end
  end
end
