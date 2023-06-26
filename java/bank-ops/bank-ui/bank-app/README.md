# Loyalty Web Application

Loyalty-App is a React Based UI which will call Loyalty Service APIs.

The app contains the following components
* Login
* Preview Loyalty Points - MyPoints \
  If the given signed-in user's group is "*User*" the app will show "MyPoints" tab in Navigation Bar.
  The given user could preview his/her loyalty points. Further see options to redeem points. 
* Manage Loyalty Points - Manage \
  If the given signed-in user's group is "*Manager*" the app will show "Manage" tab in Navigation Bar.

The loyalty points will be displayed user MyPoints tab. 
The user can then view or redeem loyalty points. 
The Manage component will call the Loyalty Service to add or get all loyalty points belonging to users.

## Prerequisites 

For this example it'll be required to register Users, Groups and Apps with [Asgardeo](https://console.asgardeo.io/t/pamod/getting-started) 
or any CIAM provider. For this example we'll mainly elaborate steps using Asgardeo.

Steps to create a user, group and app in Asgardeo is described in the following link. <TODO>

## Configuration

The following configuration is required to run the app.

`src/constants/links.js` file contains the following configuration.

```
export const AsgardeoConfig = {
  signInRedirectURL: "http://<HOST>:<PORT>",
  signOutRedirectURL: "http://<HOST>:<PORT>",
  clientID:"<CLIENT_ID>",
  baseUrl: "<BASE_URL>",
  scope: ["openid", "groups", "profile"]
};
```

`<HOST>` - Name of the host in which the app is running. \
`<PORT>` - Port of the app. \
`<CLIENT_ID>` - Client ID of the app (Taken from Asgardeo). \
`<BASE_URL>` - Base URL of the Asgardeo instance (depending on the organization created).

Replace the above configuration with what's applicable to your environment.

Default configuration assumes that the app is running in `http://localhost:3000` and the Asgardeo instance is running in `https://console.asgardeo.io/t/pamodorg`.
Hence the configuration will be as follows.

```export const AsgardeoConfig = {
  signInRedirectURL: "http://localhost:3000",
  signOutRedirectURL: "http://localhost:3000",
  clientID:"<CLIENT_ID>",
  baseUrl: "https://console.asgardeo.io/t/pamodorg",
  scope: ["openid", "groups", "profile"]
};
```
`src/constants/links.js` file also contains the following configuration.
    
```
//Loyalty Service Host and Port
export const Hosts = {
  Loyalty: "http://<HOST>:<PORT>"
};
```
    
`<HOST>` - Name of the host in which the Loyalty REST Service is running. \
`<PORT>` - Port of the Loyalty Service.

Replace the above configuration with what's applicable to your environment.

Default configuration assumes that the Loyalty Service is running in `http://localhost:8080`. Hence the configuration will be as follows.

```
//Loyalty Service Host and Port
export const Hosts = {
  Loyalty: "http://localhost:8080"
};
```

## Build and Run the Service

Execute the following command 

### `npm install && npm start` 

Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

