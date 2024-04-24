# README

This README would normally document whatever steps are necessary to get the
application up and running.

## SYSTEM REQUIREMENTS

### Ruby version 3.3.0
### Rails version 7.1.3
#### or
### Docker ( If you want to run the project on Docker)

## INSTALLATION

1. Clone the repository
2. Run `bundle install` to install all the required gems
3. Run `rails db:create` to create the database (this project utilised sqlite3 and will add the database file to the storage folder in the project)
4. Run `rails db:migrate` to run the migrations
5. Run `rails db:seed` to seed the database with the required data
6. Run `rails s` to start the server
#### Alternatively, you can run this project on Docker by running the following commands:
1. run `docker build -t wildpayments-docker` to build the docker image
2. run `docker run -p 3000:3000 wildpayments-docker` to run the docker image

## System dependencies
1. Ruby version 3.3.0
2. Rails version 7.1.3
## Configuration
###  Database creation
SQLite is a server-less relational database management system, which is embedded and doesn't require installation.
To create the database, run the following command:
`rake db:create`
### Database initialization
To initialize the database, run the following command:
`rake db:migrate`
### Seed the database
for your convenience, the database is seeded with the required data utilizing Faker. To seed the database, run the following command:
rake db:seed
## Testing
This project utilizes RSpec for testing. To run the test suite, run the following command:
`rspec`
### How to run the test suite
Run `rspec` to run the test suite.
Running the test suite will run the tests for the models, requests, facades, and routing. However,
you can also run the test for particular request route model and faces with the following commands:
- `rspec spec/models`
- `rspec spec/requests`
- `rspec spec/facades`
- `rspec spec/routing`

#### This testing uses the following gems:
- rspec-rails
- factory_bot_rails
- faker
- shoulda-matchers
- database_cleaner
- simplecov

## Deployment options:
Although this application was built as a case and didn't tend to deploy to production, it  can be deployed on any server that supports Ruby on Rails  or docker
### Heroku
This project can be deployed on Heroku. To deploy the project on Heroku, follow the steps below:
1. Create an account on Heroku
2. Install the Heroku CLI
3. Run `git remote add heroku' https://git.heroku.com/my-heroku-app.git` to add the Heroku remote
4. Run `git push heroku main` to push the code to Heroku
##### Important: before deploying to live server enable rack-cors
1. Enable the rack-cors gem in the Gemfile and run `bundle install` before deploying to the live server to avoid CORS issues.
2. Ensure that CORS issues are avoided when the API is called from the frontend app by setting it to true in the cors.rb file in the config/initializers folder.
3. In the cors.rb initializer file, you can specify the origins that are allowed to make requests, what resources they can request, and any specific HTTP headers or HTTP methods they can use.
### Docker (local deployment)
This project can be deployed on Docker. To deploy the project on Docker, follow the steps below:
1. Run `docker build -t wildpayments-docker` to build the docker image  
2. Run `docker run -p 3000:3000 wildpayments-docker` to run the docker image


### API endpoints
#### Organisations:
- GET /api/v1/organisations
- GET /api/v1/organisations/:id 
- POST /api/v1/organisations
- PUT /api/v1/organisations/:id
- DELETE /api/v1/organisations/:id\
- POST /api/v1/organisations/:id/transfer_payment

The API endpoint `GET /api/v1/organisations` retrieves a list of all organisations along with information on their last
three payment records within the attribute last_payments which includes date ,amount sender,receiver.

Attributes for the organisation model include:
- name: the name of the organisation (*required*)
- address: the address of the organisation(*required*)
- email: the email of the organisation (*required*)
- country: the country of the organisation
- province: the province of the organisation
- zip: the zip code of the organisation
- vat_id: the VAT number of the organisation (*required*)
- segment: the segment of the organisation (*required*)
- crm_id: the CRM id of the organisation (*required*)

The endpoint `POST /api/v1/organisations/:id/transfer_payment` allows you to transfer payment from one organisation to another. 
This action is based on the assumption that they have the resources to make the payment. 
To transfer payment, it requires the following parameters:
- amount: the amount of the payment (*required*)
- receiver_id: the id of the receiver (*required*)

#### Payments:
- GET /api/v1/payments
- GET /api/v1/payments/:id
- POST /api/v1/payments
- PUT /api/v1/payments/:id

The endpoint `GET /api/v1/payments` allows you to retrieve all payments. The response will be paginated with 20 records 
per page. You can also filter the results by passing `{"query":{"organisation_id": some id}}` in the request body to 
filter by organisation_id. The response will include metadata with the total number of records, the total number of 
pages, page number, the number of records per page, and next and previous page links.

Attributes for the payment model include:
- amount: the amount of the payment (*required*)
- sender_id: the id of the sender (*required*)
- receiver_id: the id of the receiver (*required*)
- organisation_id: the id of the organisation (*required*)
 
