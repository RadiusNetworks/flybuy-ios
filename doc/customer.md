# FlyBuy SDK for iOS: Customers

## Create a Customer

```swift
// Create the customer info struct

let customerInfo = CustomerInfo(
  name: name,
  carType: carType,
  carColor: carColor,
  licensePlate: licensePlate
)

// Post it to the API

FlyBuy.customer.create(customerInfo) { (customer, error) -> (Void) in
  // Handle customer or deal with error
}
```

## Get the current customer.

Returns an instance of the current customer

```swift
FlyBuy.customer.current
```

## Sign out the current customer

Signs out the current customer.

```swift
FlyBuy.customer.signOut()
```

