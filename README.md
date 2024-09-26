# PaymentApplicationDemo 
***PaymentApplicationDemo*** is a Ruby on Rails application built to facilitate payment processing between organizations.
It offers a set of APIs to initiate and manage payments, as well as process refunds. This project showcases the use of a
payment engine that is decoupled from the main application, providing several key benefits:

- ***Isolation:*** The payment engine's codebase is separated from the main application, making it easier to manage and maintain.
- ***Reusability:*** The engine can be reused across multiple projects without duplicating code.
- ***Versioning:*** The engine can be versioned independently from the main application, enabling better control over dependencies and updates.
- 
Additionally, the application follows a facade pattern to separate business logic from controllers, adding an extra layer of flexibility and maintainability.
## SYSTEM REQUIREMENTS

### Ruby version 3.3.0
### Rails version 7.1.3
### PsotgresSQL 13.3
#### or
### Docker ( If you want to run the project on Docker)

## INSTALLATION

1. Clone the repository
2. Run `bundle install` to install all the required gems
3. Run `rails db:create` to create the database (this project utilised sqlite3 and will add the database file to the storage folder in the project)
4. Run `rails db:migrate` to run the migrations
5. Run `rails db:seed` to seed the database with the required data
6. Run `rails s` to start the server

## System dependencies
1. Ruby version 3.3.0
2. Rails version 7.1.3
## API endpoints
#### Payments:
```
- GET /api/v1/payments
- Response :{Payments: [{
            "id": 1,
            "vendor_id": 1,
            "sender_id": 5,
            "receiver_id": 1,
            "amount": "248.26",
            "status": "pending",
            "created_at": "2024-09-26T06:32:05.464Z",
            "updated_at": "2024-09-26T06:32:05.464Z"
        },{....}], metadata: {total: 1, page: 1, per_page: 20, total_pages: 1, next_page: nil, prev_page: nil}}
- Exepted request body for filtering: {"organisation_id": 1} will return all payments from/to the organisation with id 1
```
```
- GET /api/v1/payments/:id
- Respose: {
            "id": 1,
            "vendor_id": 1,
            "sender_id": 5,
            "receiver_id": 1,
            "amount": "248.26",
            "status": "pending",
            "created_at": "2024-09-26T06:32:05.464Z",
            "updated_at": "2024-09-26T06:32:05.464Z"
        }
```
```
POST /api/v1/payments
Request params: {
                "amount": 248.26,
                "sender_uuid": 5ssjll-ss-nn-ss,
                "receiver_uuid": 1jll-ss-nn-ss,
                "vendor_uuid": 1a-ss-nn-ss
            }
Response 200 : {
{
    "status": "success",
    "message": "Payment initiated successfully",
}
Response 422 : {
{
    "status": "failed",
    "message": "Invalid sender or receiver or vendor" OR "Insufficient balance"
}      
```
```
POST /api/v1/payments/:id/refund
Response 200 : {
{
    "status": "success",
    "message": "Payment initiated successfully",
}
- response 422 : {
{
    "status": "failed",
    "message": "Payment not found" OR "Payment already refunded"
}      
```
The endpoint `GET /api/v1/payments` allows you to retrieve all payments. The response will be paginated with 20 records
per page. You can also filter the results by passing `{"organisation_id": some id}}` in the request body to
filter by organisation_id.

#### Attributes for the payment model include:
- amount: the amount of the payment (*required*)
- sender_id: the id of the sender (*required*)
- receiver_id: the id of the receiver (*required*)
- organisation_id: the id of the organisation (*required*)


### Organisations:
- ```GET /api/v1/organisations```
- ```GET /api/v1/organisations/:id```
- ```POST /api/v1/organisations```
- ```PUT /api/v1/organisations/:id```
- ```DELETE /api/v1/organisations/:id```
  Attributes for the organisation model include:
- name: the name of the organisation (*required*)
- address: the address of the organisation(*required*)
- email: the email of the organisation (*required*)
- country: the country of the organisation
- province: the province of the organisation
- zip: the zip code of the organisation
- vat_id: the VAT number of the organisation (*required*)
- segment: the segment of the organisation (*required*)
### View Last Payments
```GET /api/v1/organisations_activity```
Returning index of all organisations with their last three payments under the key ```last_three_payments```
```Response :{"payments": [
  {
  "id": 1,
  "uuid": "74960",
  "name": "My update name",
  "address": "4835 Alonso Ways",
  "country": null,
  "province": null,
  "zip": null,
  "vat_id": "9050849648",
  "email": "
```Response :{"payments": [
  {
  "id": 1,
  "uuid": "74960",
  "name": "My update name",
  "address": "4835 Alonso Ways",
  "country": null,
  "province": null,
  "zip": null,
  "vat_id": "9050849648",
  "email": "ndddd@ddws.dd",
  "segment": "Books, Outdoors & Industrial",
  "balance": "4955.04",
  "created_at": "2024-09-23T16:14:23.449Z",
  "updated_at": "2024-09-25T18:45:39.260Z",
  "last_three_payments": [
  {
  "id": 19,
  "created_at": "2024-09-26T06:32:05.548668",
  "amount": 420.97,
  "receiver_id": 5
  },
  {
  "id": 11,
  "created_at": "2024-09-26T06:32:05.514213",
  "amount": 820.94,
  "receiver_id": 6
  }
  ]
  },...], metadata: {total: 1, page: 1, per_page: 20, total_pages: 1, next_page: nil, prev_page: nil}}
  ```


## Pagination
The API endpoints that return multiple records are paginated. The default number of records per page is 20, but you can change
it use Pagy gem. where multiple records queried, you can pass the page number and the number of records per page as query parameters in the request URL.
The response will include metadata with the total number of records, the total number of
pages, page number, the number of records per page, and next and previous page links.



## Configuration
###  Database creation
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


