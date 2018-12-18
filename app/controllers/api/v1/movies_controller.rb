class Api::V1::MoviesController < Api::V1::BaseController
  skip_before_action :authorized_request!, only: [:index, :show]
  before_action :set_movie, only: [:show, :update, :destroy]

  def index
    movies = Movie.all
    render json: movies, status: :ok
  end

  def show
    render json: @movie, status: :ok
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :ok
    else
      render json: { errors: @movie.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render json: @movie, status: :ok
    else
      render json: { errors: @movie.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @movie.destroy
      render json: {}, status: :no_content
    end
  end

  private

  def movie_params
    params.require(:movie)
          .permit(
            :title, :release_year,
            casting_ids: [],
            director_ids: [],
            producer_ids: []
          )
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
