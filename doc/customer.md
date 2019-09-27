# Customers

## Create a Customer

Create a customer account using information from the user. Consent should be collected from the user (e.g. checkboxes).

```swift
// Create the customer info struct
let customerInfo = CustomerInfo(
  name: "Marty McFly",
  carType: "DeLorean",
  carColor: "Silver",
  licensePlate: "OUTATIME",
  phone: "555-5555"
)

// Post it to the API
FlyBuy.customer.create(withInfo: customerInfo, termsOfService: true, ageVerification: true) { (customer, error) -> (Void) in
  // Handle customer or deal with error
}
```

_Note: The `phone` parameter is optional_

## Login Via Customer Token

Login the user with a previously obtained customer API token

```
FlyBuy.customer.loginWithToken(token: "tAXDF4dPM38xkizypu4V5AYq") { (customer, error) -> (Void) in
  if let customer = customer {
    print(customer)
  }
  if let error = error {
    print(error.localizedDescription)
  }
}
```

## Login

Login the user in using existing credentials

```swift
FlyBuy.customer.login("test@example.com", "password") { (customer, error) -> (Void) in
  // Handle customer or deal with error
}
```

## Update a Customer

Update customer info for the logged in user

```swift
let customerInfo = CustomerInfo(
  name: "Marty McFly",
  carType: "DeLorean",
  carColor: "Silver",
  licensePlate: "OUTATIME",
  phone: "555-5555"
)

FlyBuy.customer.update(customerInfo) { (customer, error) ->
    // Handle customer or deal with error
}
```

## Sign Up a Customer

Link an email and password with the current anonymous logged in user.

```swift
FlyBuy.customer.signUp("test@example.com", "password") { (customer, error) -> (Void) in
  // Handle customer or deal with error
}
```

## Get the current Customer

Returns an instance of the current customer

```swift
FlyBuy.customer.current
```

## Sign out the current Customer

Signs out the current customer.

```swift
FlyBuy.customer.logout()
```

