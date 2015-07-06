require 'rails_helper'

describe "UsersController API" do

  describe "#index" do

    before(:each) do
      FactoryGirl.create_list(:user, 20)
    end

    context "no page specified" do
      it "returns 15 users" do
        get '/api/users'
        json = JSON.parse(response.body)
        expect(json["users"].count).to eq(15)
        expect(response).to be_success
      end

      it "returns first 15 sorted by last name" do
        FactoryGirl.create(:user, last_name: "Abc")
        get '/api/users'
        json = JSON.parse(response.body)

        # created last but returned first
        expect(json["users"][0]["last_name"]).to eq("Abc")
      end

      it "returns the page data [num_pages, current, num_items]" do
        get '/api/users'
        json = JSON.parse(response.body)

        expect(json["page"]["num_pages"]).to eq(2)
        expect(json["page"]["current"]).to eq(0)
        expect(json["page"]["num_items"]).to eq(20)
      end

      it "users includes last_name, job_title, description, rating, id, comments, following" do
        user = FactoryGirl.create(:user, last_name: "Abc", job_title: "top",
            description: "great")
        get '/api/users'
        json = JSON.parse(response.body)

        expect(json["users"][0]["last_name"]).to eq(user.last_name)
        expect(json["users"][0]["first_name"]).to eq(user.first_name)
        expect(json["users"][0]["job_title"]).to eq(user.job_title)
        expect(json["users"][0]["description"]).to eq(user.description)
        expect(json["users"][0].key?("rating")).to be
        expect(json["users"][0].key?("id")).to be
        expect(json["users"][0]["comments"]).to eq([])
        expect(json["users"][0].key?("following")).to be
      end
    end

    context "page 2 specified" do
      it "returns 5 users" do
        get '/api/users?page=2'
        json = JSON.parse(response.body)
        expect(json["users"].count).to eq(5)
        expect(response).to be_success
      end
    end
  end

  describe "#show" do
    it "user includes first_name, last_name, email, job_title, description,
        rating, comments, following, portfolio, picture_url" do
      user = FactoryGirl.create(:user, last_name: "Abc", job_title: "top",
          description: "great", email: "tester@gmail.com")
      get "/api/users/#{user.id}"
      json = JSON.parse(response.body)

      expect(json["last_name"]).to eq(user.last_name)
      expect(json["email"]).to eq(user.email)
      expect(json["first_name"]).to eq(user.first_name)
      expect(json["job_title"]).to eq(user.job_title)
      expect(json["description"]).to eq(user.description)
      expect(json.key?("rating")).to be
      expect(json.key?("picture_url")).to be
      expect(json["comments"]).to eq([])
      expect(json["portfolio"]).to eq([])
      expect(json.key?("following")).to be
    end
  end
end
