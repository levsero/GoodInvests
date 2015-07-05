require 'rails_helper'

RSpec.describe Company, :type => :model do
  describe "associations" do
    it { should have_many(:comments)}
    it { should have_many(:followers)}
    it { should have_many(:ratings)}
  end

  let(:company) { FactoryGirl.create(:company)}

  describe "custom attr display" do
    it "returns single name capitalized" do
      company = FactoryGirl.create(:company, name: "test")
      expect(company.name).to eq("Test")
    end

    it "returns multiple names capitalized" do
      company = FactoryGirl.create(:company, name: "test one")
      expect(company.name).to eq("Test One")
    end
  end

  describe "price attr display" do
      let(:company) { FactoryGirl.create(:company, prev_price: 32.234)}
    it "will display maximum 2 decimal places" do
      expect(company.prev_price).to eq(32.23)
    end

    it "will not display more then 2 decimal places" do
      expect(company.prev_price).to_not eq(32.234)
    end
  end

  describe "prev_price attr display" do
      let(:company) { FactoryGirl.create(:company, prev_price: 32.234)}
    it "will display maximum 2 decimal places" do
      expect(company.prev_price).to eq(32.23)
    end

    it "will not display more then 2 decimal places" do
      expect(company.prev_price).to_not eq(32.234)
    end
  end

  describe "rating" do
    it "calculates rating" do
      nums = []
      5.times do
        num = rand(5) + 1
        nums << num
        user = FactoryGirl.create(:user, email: Faker::Internet.email)

        rating = FactoryGirl.create(:rating, rater_id: user.id, rateable_id: company.id,
          rating: num, rateable_type: "Company")
      end
      average = ( nums.inject(:+).to_f / nums.length).round(2)
      expect(company.rating).to eq(average)
    end
  end
end
