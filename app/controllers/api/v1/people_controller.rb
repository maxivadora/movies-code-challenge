class Api::V1::PeopleController < Api::V1::BaseController
  def index
    @people = Person.all
    render json: @people
  end
end
