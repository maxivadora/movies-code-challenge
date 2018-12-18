class Api::V1::PeopleController < Api::V1::BaseController
  before_action :set_person, only: [:show, :update, :destroy]

  def index
    @people = Person.all
    render json: {people: @people}, status: :ok
  end
  
  def create
    @person = Person.new(person_params)
    
    if @person.save
      render json: @person, status: :ok
    else
      render json: { errors: @person.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: {
      person: @person,
      movies_as_actor_actress: @person.movies_as_actor_actress,
      movies_as_producer: @person.movies_as_producer,
      movies_as_director: @person.movies_as_director,
      },
      status: :ok
  end

  def update
    if @person.update(person_params)
      render json: {
        person: @person,
        movies_as_actor_actress: @person.movies_as_actor_actress,
        movies_as_producer: @person.movies_as_producer,
        movies_as_director: @person.movies_as_director,
        },
        status: :ok
    else
      render json: { errors: @movie.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @person.destroy
      render json: {}, status: :no_content
    end
  end

  private

  def person_params
    params.require(:person).permit(:last_name, :first_name, :aliases)
  end

  def set_person
    @person = Person.find(params[:id])
  end
end
