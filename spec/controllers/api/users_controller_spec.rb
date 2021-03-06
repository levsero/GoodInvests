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

        # created last but return first
        expect(json["users"][0]["last_name"]).to eq("Abc")
      end

      it "returns the page data [num_pages, current, num_items]" do
        get :index, format: :json

        expect(json["page"]["num_pages"]).to eq(2)
        expect(json["page"]["current"]).to eq(0)
        expect(json["page"]["num_items"]).to eq(20)
      end

      it "users include name, job_title, description, rating, id, comments, following" do
        user = FactoryGirl.create(:user, last_name: "Abc")
        get :index, format: :json

        expected = {"first_name"=>user.first_name, "last_name"=> user.last_name,
          "job_title"=> user.job_title, "description"=>user.description,
          "rating"=>0, "comments"=>[], "following"=>false, "id"=> user.id}

        expect(json["users"][0]).to eq(expected)
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

  describe "#create" do
    context "valid data passed in" do
      before { post :create, format: :json, user: {first_name: "What", last_name: "Ever",
        password: "testing", email: "test@gmail.com"} }

      it "creates a user if all required fields passed" do
        expect(User.last.email).to eq("test@gmail.com")
      end

      it "returns users data" do
        expected = {"first_name"=>"What", "last_name"=> "Ever","job_title"=> nil,
          "email"=> "test@gmail.com", "rating"=>0, "comments"=>[], "following"=>false,
          "portfolio"=>[], "picture_url"=>"http://test.host/images/medium/missing.png",
          "description"=> nil}

        expect(json).to eq(expected)
        expect(response).to be_success
      end
    end

    context "invalid data passed in" do
      before { post :create, format: :json, user: {first_name: "What", last_name: "Ever",
          password: "testing", email: ""} }

      it "does not create user " do
        expect(User.last).to_not be
      end

      it "returns unprocessable with error messages" do
        expect(response).to be_unprocessable
        expect(json).to include("Email is not a valid email address")
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

    it "returns 'current_user: true' if user == current_user" do
      allow(controller).to receive(:current_user) { user }
      get :show, format: :json, id: user.id

      expect(json["current_user"]).to eq(true)
      expect(response).to be_success
    end
  end

  describe "#update" do
    context "current_user == :user_id" do
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
    end

    context "current_user != :user_id" do
      it "returns unprocessable" do
        user2 = FactoryGirl.create(:user)
        allow(controller).to receive(:current_user) { user }

        patch :update, format: :json, id: user2.id, :user => {first_name: "updated"}
        expect(response.body).to eq("[]")
        expect(response).to be_unprocessable
      end
    end
  end

  describe "#logged_in" do
    context "user is signed in" do
      it "returns current_users data" do
        allow(controller).to receive(:current_user) { user }

        get :logged_in, format: :json

        expected = {"first_name"=>user.first_name, "last_name"=> user.last_name,
          "job_title"=> user.job_title, "description"=>user.description,
          "id"=> user.id, "notifications"=>[], "notifications_count" => 0,
          "picture_url" => "http://test.host/images/thumb/missing.png"}

        expect(json).to eq(expected)
        expect(response).to be_success
      end
    end
  end

  describe "#password_reset" do
    context "matching token and id" do
      it "resets users password if valid password" do
        get :password_reset, format: :json, token: user.session_token, id: user.id,
            password: "new_password"

        expect(User.find(user.id).is_password?("new_password")).to be true
        expect(response).to be_success
      end

      it "returns unprocessable and password too short" do
        get :password_reset, format: :json, token: user.session_token, id: user.id,
            password: "new_"

        expect(response.body).to eq("password too short, minimum 6 characters")
        expect(response).to be_unprocessable
      end
    end

    it "returns unprocessable if token doesn't match id" do
      user2 = FactoryGirl.create(:user)
      get :password_reset, format: :json, token: user2.session_token, id: user.id,
          password: "new_password"

      expect(response).to be_unprocessable
    end
  end
end
