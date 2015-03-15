module Api
  class CompaniesController < ApplicationController
    def index
      @user = current_user

      page = Company.page(params[:page])
      @page_info = {num_pages: page.total_pages, current: params[:page].to_i,
        num_items: page.total_count}

      @companies = page
    end

    def show
      @user = current_user
      @company = Company.find(params[:id])
    end
  end
end
