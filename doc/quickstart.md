# FlyBuy SDK for iOS Quick Start

![FlyBuy logo](img/flybuy-heading.jpg)

Last Updated: January X, 2019

**Requirements:**

* iOS X.X and above

**Constraints**
Although the FlyBuy SDK can be used in the iOS Simulator, it will not be able to simulate orders due to constraints of the iOS simulator.

**Create an account**
You’ll need to [create an account](https://account.radiusnetworks.com/users/sign_up) to complete the steps below. Already have an account? [Sign in](http://flybuy.radiusnetworks.com/).

## Step 1: Add the SDK to your project

### Get an API key
Log into the FlyBuy web administration and select *Manage project* to access your project. You can view and create API keys under the API keys section in the right sidebar.

There are two types of API keys, development keys and production keys. You can manage and create API keys through FlyBuy web administration. Enable production keys by contacting your Account Executive. Your mobile SDK and dashboard must use the same environment.

### Install the SDK
Download the SDK from the following link: [https://github.com/RadiusNetworks/flybuy-ios](https://github.com/RadiusNetworks/flybuy-ios)

### Adding FlyBuy to your project
In order to use the FlyBuy framework, simply drag it into your Xcode project.

Under the `General` tab for your iOS target, make sure that `FlyBuy.framework` appears in both `Embedded Binaries` and `Linked Frameworks`.

Be sure to include the following in the appropriate header and/or implementation file(s) depending on your language:

**Objective-C:**

```
@import FlyBuy;
```

**Swift:**

```
import FlyBuy
```

### Enable Background Modes
Under the General tab for your iOS target, select Capabilities and scroll down to Background Modes. Make sure that Location updates and Background fetch are selected.

### Ask for Location Services permissions
FlyBuy uses mobile sensor data to identify the location of a customer.  The FlyBuy SDK requires Location services permissions to properly function. Specifically, the SDK needs the Location Always and When in Use permission.

If you are already asking users for the required permissions, you should review the usage description. The usage description explains why the application requires Always authorization.

If you currently do not ask users for the required permissions, you should add a usage description to your app. Usage descriptions are set in the Info.plist file.

A best practice is to ask your users for location TODO

Name  | Suggested Description
------------- | -------------
`NSLocationAlwaysAndWhenInUseUsageDescription`  | To accurately locate you for order delivery
`NSLocationWhenInUseUsageDescription`  | To accurately locate you for order delivery

## Step 2: Add a site
A site is a physical location that is a destination for your customer’s trips. Typically a project is created for a given brand, and sites are created for each of the stores.

Each site has a some required parameters, and optionally configurable parameters.

**Required parameters:**

* Display Name - A display name for the location
* Site Number - Your identifier or store number used to identify the site.
* Address - A full street address, including street address, city/locality, state/region, postal code, and country
* Time Zone - The time zone of the location

**Optional parameters:**

* Site photo - A photo of the location to help guide the customers for pickup
* Site description - Details about the location and how to find it
* Pickup instructions - Provide guidance for how to best pickup orders at this location
* Property: Draw property boundaries for the particular location.
* Areas: Configure pickup areas, including curbside areas, drive thru lanes, and in-store pickup areas.

## Step 3: Create an order
Create order

Cancel order

Get site information

Events

Error handling

Other

* Get nearby sites
* API documentation

## Step 4: View the dashboard
The SDK is now fully integrated with your app. You can access the Dashboard to view customers with active orders.
