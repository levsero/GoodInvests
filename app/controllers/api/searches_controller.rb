module Api
  class SearchesController < ApplicationController
    def search
      page = PgSearch.multisearch(params[:query])
      .includes(:searchable)
      .page(params[:page])

      @page_info = {num_pages: page.total_pages, current: params[:page].to_i,
        num_items: page.total_count}

      @search_results = page
      
      render :search
    end
  end
end
