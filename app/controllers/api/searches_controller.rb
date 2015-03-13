module Api
  class SearchesController < ApplicationController
    def search
      @search_results = PgSearch
        .multisearch(params[:query])
        .includes(:searchable)
        # .page(params[:page])

      render :search
    end
  end
end
