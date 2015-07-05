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

  describe "update_prices" do
    before(:each) do
      response = "asd asdf,13.1 adf,12.23"
      allow(company).to receive(:get_updates).and_return(response)
    end

    it "does not call get_updates if updated less then 1 day ago" do
      company.updated_at = 1.hour.ago
      expect(company).to_not receive(:get_updates)
      company.update_prices
    end

    it "calls get_updates if updated more then 1 day ago" do
      company.updated_at = 2.days.ago
      expect(company).to receive(:get_updates)
      company.update_prices
    end

    it "updates price eq second line" do
      company.updated_at = 2.days.ago
      company.update_prices
      expect(company.price).to eq(13.1)
    end

    it "updates prev_price eq third line" do
      company.updated_at = 2.days.ago
      company.update_prices
      expect(company.prev_price).to eq(12.23)
    end
  end
end
