# FlyBuy Data Models

Several data objects are used and returned by the FlyBuy SDK. These include:

- [FlyBuy Data Models](#flybuy-data-models)
  - [Customer Info](#customer-info)
  - [Customer](#customer)
  - [Site](#site)
  - [Order](#order)
    - [Customer State ENUM Values](#customer-state-enum-values)
    - [Order State ENUM Values](#order-state-enum-values)
    - [Pickup Window](#pickup-window)
  - [Errors](#errors)

## Customer Info

The `CustomerInfo` type is used to update customer information. It is also returned in the `Order` for the customer information for an order.

```swift
open class CustomerInfo {
    public let name: String
    public let carType: String?
    public let carColor: String?
    public let licensePlate: String?
    public let phone: String?
}
```

## Customer

The `Customer` type provide details of the current customer using `FlyBuy.customer.current` and is returned after creating a customer or logging in.

```swift
open class Customer {
    public let token: String
    public let emailAddress: String?
    public let info: CustomerInfo
}
```

## Site

The `Site` type provides details for a particular site.

```swift
open class Site {
    public let id: Int
    public let partnerIdentifier: String?
    public let name: String?
    public let phone: String?
    public let fullAddress: String?
    public let longitude: String?
    public let latitude: String?
    public let instructions: String?
    public let descriptionText: String?
    public let coverPhotoURL: String?
}
```

## Order

The `Order` type provides details for a order.

```swift
open class Order {
    public let id: Int
    public var state: OrderState
    public var customerState: CustomerState
    public let partnerIdentifier: String?
    public let pickupWindow: PickupWindow?
    public let pickupType: String?
    public var etaAt: Date?
    public let redeemedAt: Date?
    public var customerRating: String?
    public var customerComment: String?

    public let siteID: Int
    public let siteName: String?
    public let sitePhone: String?
    public let siteFullAddress: String?
    public let siteLongitude: String?
    public let siteLatitude: String?
    public let siteInstructions: String?
    public let siteDescription: String?
    public let siteCoverPhotoURL: String?

    public let customerID: String?
    public let customerName: String?
    public let customerCarType: String?
    public let customerCarColor: String?
    public let customerLicensePlate: String?
}
```

### Customer State ENUM Values

`CustomerState` provides the current status of the customer.

| Value       | Description                                                             |
|-------------|-------------------------------------------------------------------------|
| `created`   | Customer has claimed their order                                        |
| `enRoute`   | Order tracking has started and the customer is on their way             |
| `nearby`    | Customer is close to the site                                           |
| `arrived`   | Customer has arrived on site                                            |
| `waiting`   | Customer is in a pickup area or has manually indicated they are waiting |
| `completed` | Order is complete                                                       |

### Order State ENUM Values

`OrderState` provide the state of the order from the merchant's perspective. 

| Value       | Description                                                             |
|-------------|-------------------------------------------------------------------------|
| `created`   | Order has been created                                                  |
| `ready`     | Order is ready for customer to claim                                    |
| `delayed`   | Order has been delayed by merchant after customer arrives               |
| `cancelled` | Merchant has cancelled order                                            |
| `completed` | Order is complete                                                       |
| `gone`      | Returned by API when order does not exist                               |

### Pickup Window 

The `PickupWindow` type provides the time range when an order is expected to be picked up. It will be `nil` if there is no pickup window, i.e., ASAP. If there is just a pickup time, the `start` and `end` will be the same.

```swift
public class PickupWindow: NSObject {
    public let start: Date
    public let end: Date
}
```

## Errors

If there is an error for any SDK method, the callback will return a swift `Error` object. 

Possible types include, but are not limited to, the following:

```swift
public class FlyBuyError : LocalizedError {
    internal(set) public var errorDescription: String?
    public let title: String
}
```

```swift
public class FlyBuyAPIError : FlyBuyError {
    public let statusCode: HTTPStatusCode?
    public var errors: [String : [String]]?
```
