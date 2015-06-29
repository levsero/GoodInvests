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
      @company.update_prices
    end

    def most_followed
      # 10 most followed companies
      # followable_id is the first num, count is the second
      @companies = Company.joins("inner join follows ON companies.id = follows.followable_id AND follows.followable_type = 'Company'")
        .select("name, ticker, companies.id, count(*) as count").group("companies.id").limit(10)

      @commented = Company.joins("inner join comments ON companies.id = comments.commentable_id AND comments.commentable_type = 'Company'")
        .select("name, ticker, companies.id, count(*) as count").group("companies.id").limit(10)
    end
  end
end
