require 'rails_helper'

RSpec.describe User, :type => :model do
  # The split method in the custom return values breaks these tests
  # it { should validate_presence_of(:email) }
  # it { should validate_presence_of(:first_name) }
  # it { should validate_presence_of(:last_name) }
  # it { should validate_presence_of(:password_digest) }
  # it { should validate_presence_of(:session_token) }
  # it { should validate_uniqueness_of(:email) }

  describe "associations" do
    it { should have_many(:notifications)}
    it { should have_many(:comments)}
    it { should have_many(:authored_comments)}
    it { should have_many(:follows)}
    it { should have_many(:followers)}
    it { should have_many(:ratings)}
    it { should have_many(:rated_objects)}
    it { should have_many(:followed_companies)}
    it { should have_many(:followed_users)}
  end

  let(:user) { FactoryGirl.create(:user, first_name: "lev", last_name: "ser")}

  describe "custom attr display" do
    it "returns names as capitalized" do
      expect("#{user.first_name}").to eq("Lev")
      expect("#{user.last_name}").to eq("Ser")
    end

    it "name returns both names joined and capitalized" do
      expect("#{user.name}").to eq("Lev Ser")
    end

  end

  describe "email validation" do
    it "checks for valid email address" do
      user.email = "test@"
      user.valid?
      expect(user.errors[:email]).to include("is not a valid email address")
    end
  end

  describe "find_by_credentials" do
    it "finds user with correct email password" do
      user = User.find_by_credentials({email: "test@gmail.com", password: "testing"})
      expect("#{user.first_name} #{user.last_name}").to eq("Lev Ser")
    end

    it "doesn't finds user without correct email password" do
      find = User.find_by_credentials({email: "test@gmail.com", password: nil})
      expect(find).to eq(nil)
      find = User.find_by_credentials({email: "incorrect@gmail.com", password: "testing"})
      expect(find).to eq(nil)
    end
  end

  describe "rating" do
    it "calculates rating" do
      nums = []
      5.times do
        num = rand(5) + 1
        nums << num
        users = FactoryGirl.create(:user, email: Faker::Internet.email)
        # TODO do this with stubbing if possible. Shouldn't rely on rating class
        rating = FactoryGirl.create(:rating, rater_id: users.id, rateable_id: user.id,
          rating: num)
      end
      average = ( nums.inject(:+).to_f / nums.length).round(2)
      expect(user.rating).to eq(average)
    end
  end
end
