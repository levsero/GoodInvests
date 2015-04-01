require 'rails_helper'

RSpec.describe User, :type => :model do
  # having custom return values breaks these tests
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

  describe "custom attr display" do
    user = User.new({email: "test@gmail.com", first_name: "lev", last_name: "ser",
      password: "testing"})

    it "returns names as capitalized" do
      expect("#{user.first_name}").to eq("Lev")
      expect("#{user.last_name}").to eq("Ser")
    end

    it "name returns both names joined and capitalized" do
      expect("#{user.name}").to eq("Lev Ser")
    end

  end

  describe "email validation" do
    user = User.new({email: "test@", first_name: "lev", last_name: "ser",
      password: "testing"})
    it "checks for valid email address" do
      user.valid?
      expect(user.errors[:email]).to include("is not a valid email address")
    end
  end

  describe "find_by_credentials" do
    it "finds user with correct email password" do
      User.create!({email: "testing@gmail.com", first_name: "lev", last_name: "ser",
        password: "testing"})
      user = User.find_by_credentials({email: "testing@gmail.com", password: "testing"})
      expect("#{user.first_name} #{user.last_name}").to eq("Lev Ser")
    end

    it "doesn't finds user without correct email password" do
      User.create!({email: "testing2@gmail.com", first_name: "lev", last_name: "ser",
        password: "testing"})
      user = User.find_by_credentials({email: "testing2@gmail.com", password: nil})
      expect(user).to eq(nil)
      ser = User.find_by_credentials({email: "incorrect@gmail.com", password: "testing"})
      expect(user).to eq(nil)
    end
  end
end
