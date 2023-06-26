# Deploy Your Webapp Instantly using WSO2 App Development Suite 

This is a sample webapp which demonstrates how to use WSO2 App Development Platform to deploy your webapp instantly.

# Description

Company XYZ intends to build a loyalty program for its customers. 
The loyalty program will be based on the number of points a customer has. 
The customer can redeem these points for various rewards. 
The loyalty program will be managed by a group of managers. 
The managers will be able to add points to a customer's account. 
The customers will be able to view their points and redeem them for rewards.

# Architecture

The Loyalty Program consists of the following components:

**Users** : Customers and Managers. \
**Web-portal** : A web portal where customers can view their points and redeem them for rewards. 
The same web portal should also be used by the managers to add points to a customer's account. \
**Loyalty Service** : A microservice that provides the following functionality (act as Domain APIs): 
* Get Loyalty Points for a customer 
* Add Loyalty Points for a customer 
* Delete Loyalty Points from a customer 
* Get All Customers with Corresponding Loyalty Points

**Security**: The web portal should identify the user signed in. If the user is a customer, the web portal should only show the customer's points.
If the user is a manager, the web portal should show all the customers and their points. allowing the manager to add points to a customer's account.

# Development LifeCycle

Let's take a look at the development lifecycle of the Loyalty Program. 

## 1. Development of Loyalty Service

Company XYZ uses SpringBoot for microservice development. Let's say the service is developed and tested locally. 
The code for service can be found in [Loyalty-Project](https://github.com/pamod/choreo-dev/tree/v1.0/java/loyalty-points-calculation/loyalty-project), 
clone or folk this directory into your Github repo. (you'll also see instructions as to how you could run this service locally)

Once you develop, next comes securing and deploying the service. In most of the projects this is known to be a time consuming process.
Let's take a rough breakdown of activities what one may've to do to take this piece of code into production. 
Let's assume the preferred deployment method is to use Kubernetes.

````
a. Create a Kubernates cluster \
b. Create multiple environments i.e dev, test, prod \
c. Create CI/CD pipelines \
d. Build the Dockerfile and upload the container to registry. \
e. Create a Kubernetes deployment file to deploy the service. \
f. Create a Kubernetes service file to expose the service. \
g. Create a Kubernetes ingress file to expose the service to the outside world. \
h. Create a Kubernetes configmap file to store the configurations of the service. \
i. Create a Kubernetes secret file to store the secrets of the service. \
j. Create a Kubernetes horizontal pod autoscaler file to scale the service. \
k. Create a Kubernetes network policy file to secure the service. \
l. *There can be more activities depending on the requirements.*. \ 
m. Once the infrastructure is ready and you deploy the service; now comes to the part of applying security and business policies. \
n. A API Management platfrom is required to apply these policies. \
o. Create a API Manager instance. and again repeat steps from b-l \
p. Then you'll realize you need to continousely monitor and take business decisions; hence you need to bring a proper analytics platform \
q. Create a Analytics instance. and again repeat steps from b-l \
````

This can be a long list of things to do. And this is just for one service. Let's say we skip all the above steps. 
There's a platform which can do all the work for you. 

1. Login to [WSO2 App Development Platform](https://console.choreo.dev/login?profile=idevp). 
2. Create a service under your organization/project. \
![create_service_1.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/create_service_1.png)
3. Provide your github repo details and click on create. If you cloned the repo mentioned above, 
you can use the below details. \
![githubdetails_2.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/githubdetails_2.png)

*Dockerfile Path*: ````java/loyalty-points-calculation/loyalty-project/Dockerfile```` \
*Docker Context Path* : ````java/loyalty-points-calculation/loyalty-project````

Also notice; all the preproduction environments are now mimicked graphically. Choreo has defined the CI/CD pipelines, 
handled the complexity of container deployment, configuration and created multiple preproduction environments. \
![githubdetails_3.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/environments_3.png)
4. User will also get the option to deploy the service in any given environment graphically.
Once deployed it can be tested using the test console, prior to publishing. \
![testing_4.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/testing_4.png)
5. By clicking on the manage button, viola you'll notice options to manage the service. 
We'll talk about options shortly. Let's maybe start by publishing the service as "pre-release" 
(available under manage-> lifecycle) \
![lifecycle_5.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/lifecycle_5.png)
6. Published API can be viewed under developer portal, which is provided by WSO2 App Development Platform.
Notice the LoyaltyService is available for consumption in the portal. \
![devportal_6.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/devportal_6.png)
7. Using the try-it tool or any REST client the relevant Loyalty Service could be accessed. 
Notice the service is now secured and could only be accessed via providing token. 
The security policies were enforced by WSO2 App Development Platform. \
![service_access_7.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/service_access_7.png)

Now we got a LoyaltyService which is secured. We still didn't authorize the service to distinguish between "User" and "Manager".
We'll get back with the steps of adding scopes to services momentarily. Before that let's take a look at getting the user interfaces ready.

## 2. Web-portal Development

Company XYZ uses ReactJS for web-portal development. Let's say the web-portal is developed and tested locally.
The code for web-portal can be found in [loyalty-ui](https://github.com/pamod/choreo-dev/tree/v1.0/java/loyalty-points-calculation/loyalty-ui/loyalty-app).
Clone or folk this directory into your Github repo. (you'll also see instructions as to how you could run this web-portal locally)

Web portal needs to contain a login page. Once the user is logged in, the web portal should identify the user signed in.
If the user is a customer, the web portal should only show the customer's points. if the user is a manager, 
web portal should allow adding points to a customer's account.

If XYZ company is to develop this web portal, they would've to do the following activities.

````
a. Create a store to hold all the customer's and managers 
b. Create a system to perform roles mapping to distiguish users and managers 
c. Manage the sessions of signed in users and manage the logout 
d. Create a page for user sign-up 
e. Create a page for user login 
f. If XYZ is to introduce more applications, will have to think about Single Sign On (SSO) \
g. If XYS is to introduce Multi Factor Authentication (MFA) 
   will have to impliment complex session management and integration flows 
f. It would be essential to have a proper identity management system
g. deployment of identity system will take the same effort as described in section 1
````

### Configure Identity Platform

WSO2 App Development Platform provides capability to perform the above with a few clicks. 

1. Login to [WSO2 App Development Identity Platform](https://asgardeo.io/signup?visitor_id=642ebc5fac6412.86756414&utm_source=site&utm_medium=organic).
2. Make sure to select the organization to be the same organization you chose in Choreo platform.
3. Add users; for this demo we'll add two users as shown below. \
![user_add_7.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/user_add_7.png)
4. Add two groups as shown below. \
![group_add_7.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/group_add_7.png)
5. Each time an application is created in Choreo platform, a corresponding application is created in Identity platform. 
Goto "Applications" tab in Identity platform and click on the application created by Choreo platform. 
In this case let's say the name of the application is "LoyaltyApplication". Under "Loyalty Application", protocol section
Make sure the following parameters are in place. 

````
Allowed Grant Types - Code, Refresh Token
Public Client - Yes
Access Token Type - JWT
Authorized Redirection URIs - http://localhost:3000
Allowed Origin - http://localhost:3000
````
**Note in this example we are using localhost:3000 as the web-portal is running locally. Replace the URL with the URL of your web-portal.**

6. Under Uer-Attributes section, add the following attributes. 

````
openid groups profile
````

### Configure Web-portal

1. Details of the web-portal can be found in [loyalty-ui](https://github.com/pamod/choreo-dev/tree/v1.0/java/loyalty-points-calculation/loyalty-ui/loyalty-app)
2. Make sure to reflect the values for AsgardeoConfig as described in [loyalty-ui](https://github.com/pamod/choreo-dev/tree/v1.0/java/loyalty-points-calculation/loyalty-ui/loyalty-app)
3. The Hosts configuration should reflect the Choreo endpoint URL. 
In the developer portal click on the API. In overview section the endpoint URL can be found.
3. Run the web-portal locally. 

## Testing the Application 

1. The home page of the application should look like below. \
![home_9.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/bank-ops/images/home_9.png)
2. When a login button is clicked, the user will be redirected to the login page generated by Asgardeo. \
![login_10.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/login_10.png)
3. Login as "admin@pamodorg.com" who's a "manager". Notice "Manage" tab is visible. Add points to a customers as shown below. \
![add_points_11.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/add_points_11.png)
4. Logout and login as "user@pamodorg.com" who's a "customer". Notice for user "MyPoints" tab is visible and 
relevant points will be shown as below. \
![view_points_12.png](https://github.com/pamod/choreo-dev/blob/v1.0/java/loyalty-points-calculation/images/view_points_12.png)





