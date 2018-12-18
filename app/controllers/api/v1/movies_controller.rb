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
    @movie = Movie.new(
      title: movie_params[:title],
      release_year: movie_params[:release_year]
    )
    
    add_person_to_movie

    if @movie.save
      render json: @movie, status: :ok
    else
      render json: { errors: @movie.errors }, status: :unprocessable_entity
    end
  end

  def update
    @movie.update(
      title: movie_params[:title],
      release_year: movie_params[:release_year]
    )

    update_person_in_movie
    
    if @movie.save
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
            people_with_role: [ :person_id, :role]
          )
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def add_person_to_movie
    movie_params[:people_with_role].each do |person_with_role|
      @movie.movie_people.build(
        person_id: person_with_role[:person_id],
        role: person_with_role[:role]
      )
    end
  end

  def update_person_in_movie
    @movie.movie_people.delete_all
    add_person_to_movie
  end
end
