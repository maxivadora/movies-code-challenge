class SearchesController < ApplicationController
  def search
    @movies = Movie.search(search_params[:text])

    respond_to do |format|
      format.js
    end
  end

  private

  def search_params
    params.permit(:text)
  end
end
