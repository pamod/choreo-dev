## Description

The Loyalty Service is a microservice that provides the following functionality:
### Loyalty Points
* Get Loyalty Points for a customer
* Add Loyalty Points for a customer
* Delete Loyalty Points from a customer
* Get All Customers with Corresponding Loyalty Points

## Running the Service

*Option 1*

Execute the following command 

`mvn spring-boot:run`

*Option 2*

Run as docker container 

`docker build -t loyalty/loyalty-service .`

`docker run -p 8080:8080 -t loyalty/loyalty-service` 

## Testing the Service

1. Log into the Loyalty Service Swagger UI at http://localhost:8080/swagger-ui.html
2. Click on the Loyalty Points Controller
3. Click on the GET /loyaltyPoints/{customerId} endpoint
4. Enter a customer ID in the customerId field
5. Click on the Try it out! button
6. Click on the Execute button
7. The response should be a JSON object with the customer ID and loyalty points
8. Similarly, you can test the other endpoints
   
