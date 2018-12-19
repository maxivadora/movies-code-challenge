# README

##Problem
A company that has a website about movies wants to provide its customers and users an API to query their database, as well as provide the trusted company users the ability to update or create new records.

In order to complete this, you must create a RESTful interface that will provide access to the company’s database.

### Requirements
* Provide a REST API to access movies and persons models.
* Safe methods are publicly available, no authentication is required.
* Unsafe methods are only available to authenticated users.
* Movie documents must include references or full documents to persons in their different roles.
* Person documents must include references or full documents to movies in the different roles the Person has.
* Movie documents must include the Release Year in roman numerals. This field should not be stored in the DB, just calculated on the fly.

### Deliverables
* The source code submitted to a shared Github repository.
* The list of available endpoints and supported methods documented (could be in the same Github repo).
* List of used libraries/frameworks.

### Extra Credit
* Project is deployed and running online (AWS, Heroku, cloud servers, own servers…)
* User interface to browse items.
* User interface to create/edit/delete items.
* Justification of chosen libraries/frameworks against other popular choices.

## API References

Base path: `/api/v1/`

### Authentication

* Authentication with Json Web Token (JWT). `Atuhentication`=`token` must be included in the request's headers for authenticated users.
* `index` and `show` are publicly available.
* `create`, `update`, `destroy` are only available to authenticated users.

### Person

* Index action: `GET` `/people`
* Show action: `GET` `/people/:id`
* Create action: `POST` `/people`
* Update action: `PUT` `/people`
* Destroy action: `DELETE` `/people/:id`
* `create` and `update` params:
  ```
  {"person": {"last_name":"string", "first_name":"string", "aliases":"string"}}
  ```


### Movie

* Index action: `GET` `/movies`
* Show action: `GET` `/movies/:id`
* Create action: `POST` `/movies`
* Update action: `PUT` `/movies`
* Destroy action: `DELETE` `/movies/:id`
* `create` and `update` params:
  ```
  {"movie": {"title":"string", "release_year":"integer", "casting_ids":[], "director_ids":[], "producer_ids":[]}}
  ```

## Development

### Requirement
* Ruby 2.4.0 
* Rails 5.2.2 
* Postgresql 

### Consideration
* Fake data includes into `seed.rb`
* Default user: `email`:`admin@admin.com`, `password`: `admin`

## Staging

URL: <http://movies-code-challenge.herokuapp.com>

