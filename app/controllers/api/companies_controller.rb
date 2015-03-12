module Api
  class CompaniesController < ApplicationController
    def index
      @user = current_user
      @companies = Company.all
    end

    def show
      @user = current_user
      @company = Company.find(params[:id])
    end
  end
end
