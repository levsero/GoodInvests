require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  # it { should validate_uniqueness_of(:email) }

  it "finds user with correct email password" do
    User.create!({email: "test@gmail.com", first_name: "lev", last_name: "ser",
      password: "testing"})
    user = User.find_by_credentials({email: "test@gmail.com", password: "testing"})
    expect("#{user.first_name} #{user.last_name}").to eq("lev ser")
  end

  it "doesn't finds user without correct email password" do
    User.create!({email: "test@gmail.com", first_name: "lev", last_name: "ser",
      password: "testing"})
    user = User.find_by_credentials({email: "test@gmail.com", password: nil})
    expect(user).to eq(nil)
    ser = User.find_by_credentials({email: "incorrect@gmail.com", password: "testing"})
    expect(user).to eq(nil)
  end
end
