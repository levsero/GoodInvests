require 'rails_helper'

RSpec.describe Api::UsersController do
  render_views

  let(:json) { JSON.parse(response.body) }
  let(:user) { FactoryGirl.create(:user, last_name: "Test", job_title: "top",
      description: "great") }

  describe "#index" do
    before(:each) do
      FactoryGirl.create_list(:user, 20)
    end

    context "no page specified" do
      it "returns 15 users" do
        get :index, format: :json
        expect(json["users"].count).to eq(15)
        expect(response).to be_success
      end

      it "returns first 15 sorted by last name" do
        FactoryGirl.create(:user, last_name: "Abc")
        get :index, format: :json

        # created last but returned first
        expect(json["users"][0]["last_name"]).to eq("Abc")
      end

      it "returns the page data [num_pages, current, num_items]" do
        get :index, format: :json

        expect(json["page"]["num_pages"]).to eq(2)
        expect(json["page"]["current"]).to eq(0)
        expect(json["page"]["num_items"]).to eq(20)
      end

      it "users includes last_name, job_title, description, rating, id, comments, following" do
        get :index, format: :json
        user = FactoryGirl.create(:user)
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
        get :index, format: :json, page: 2
        expect(json["users"].count).to eq(5)
        expect(response).to be_success
      end
    end
  end

  describe "#show" do
    it "returns specified users data" do
      user = FactoryGirl.create(:user, last_name: "Abc", job_title: "top",
          description: "great", email: "tester@gmail.com")

      get :show, format: :json, id: user.id

      expected = {"first_name"=>user.first_name, "last_name"=> user.last_name,
        "job_title"=> user.job_title, "description"=>user.description,
        "email"=>user.email, "rating"=>0, "comments"=>[], "following"=>false,
        "portfolio"=>[], "picture_url"=>"http://test.host/images/medium/missing.png"}

      expect(json).to eq(expected)
      expect(response).to be_success
    end

    it "additionally returns 'current_user: true' if user == current_user" do
      allow(controller).to receive(:current_user) { user }
      get :show, format: :json, id: user.id

      expect(json["current_user"]).to eq(true)
      expect(response).to be_success
    end
  end

  describe "#update" do
    it "returns user show with updated data" do
      allow(controller).to receive(:current_user) { user }

      patch :update, format: :json, id: user.id, :user => {first_name: "updated"}

      expected = {"first_name"=>"Updated", "last_name"=> user.last_name,
        "job_title"=> user.job_title, "description"=>user.description,
        "email"=>user.email, "rating"=>0, "comments"=>[], "following"=>false,
        "portfolio"=>[], "picture_url"=>"http://test.host/images/medium/missing.png",
        "current_user"=>true}

      expect(json).to eq(expected)
      expect(response).to be_success
    end

    it "does not update if id is not the current_user" do
      user2 = FactoryGirl.create(:user)
      allow(controller).to receive(:current_user) { user }

      patch :update, format: :json, id: user2.id, :user => {first_name: "updated"}
      expect(response.body).to eq("[]")
      expect(response).to be_unprocessable
    end
  end
end
