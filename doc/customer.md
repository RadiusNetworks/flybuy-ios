# Customers

## Create a Customer

```swift
// Create the customer info struct

let customerInfo = CustomerInfo(
  name: name,
  carType: carType,
  carColor: carColor,
  licensePlate: licensePlate,
  phone: customerPhone
)
```

_Note: The `phone` parameter is optional_

```swift
// Create the customer consent struct, indicating that the customer has
// consented with Terms of Service & Privacy Policy and is old enough
// to provide consent.
let consent = CustomerConsent(
  termsOfService: true,
  ageVerification: true
)

// Post it to the API

FlyBuy.customer.create(withInfo: customerInfo, consent: consent) { (customer, error) -> (Void) in
  // Handle customer or deal with error
}
```

## Login Via Customer Token
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

## Get the current Customer

Returns an instance of the current customer

```swift
FlyBuy.customer.current
```

## Sign out the current Customer

Signs out the current customer.

```swift
FlyBuy.customer.signOut()
```
