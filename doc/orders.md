# Orders

Examples are in Swift. Refer to [Data Models](data_models.md) for details on classes and objects used by the SDK.

- [Fetch Claimed Orders](#fetch-claimed-orders)
- [Fetch Unclaimed Orders](#fetch-unclaimed-orders)
- [Observe Orders](#observe-orders)
- [Claim Orders](#claim-orders)
- [Create Orders](#create-orders)
- [Update Orders](#update-orders)
  - [Update customer state](#update-customer-state)
  - [Update order state](#update-order-state)
- [Customer Ratings](#customer-ratings)

## <span id="fetch-claimed-orders">Fetch Claimed Orders</span>

Fetch syncs the SDK with the FlyBuy backend to ensure the state changes match between the systems.

When to Fetch:
- app startup (required)
- claiming an order (required)
- showing a list of orders (optional)

```swift
FlyBuy.orders.fetch()
```

Return the cached list of orders for the current user.

```swift
FlyBuy.orders.all
```

Return the cached list of open orders for the current user.

```swift
FlyBuy.orders.open
```

Return the cached list of closed orders for the current user.

```swift
FlyBuy.orders.closed
```

## <span id="fetch-unclaimed-orders">Fetch Orders with Redemption Code</span>

```swift
FlyBuy.orders.fetch(withRedemptionCode: code) { (order, error)
  // Check error response and update order claim view with order details here
}
```

## <span id="observe-orders">Observe Orders</span>

Set up observers to get updates about orders. You can add a method like `registerForNotifications()` in a view controller and call it from `viewDidLoad()`.

```swift
override func viewDidLoad() {
  super.viewDidLoad()
  registerForNotifications()
}

func registerForNotifications() {
  NotificationCenter.default.addObserver(forName: .ordersUpdated, object: nil, queue: nil) { (notification) in
    // Update multiple orders
  }
  NotificationCenter.default.addObserver(forName: .orderUpdated, object: nil, queue: nil) { (notification) in
    // Update single order
  }
  NotificationCenter.default.addObserver(forName: .ordersError, object: nil, queue: nil) { (notification) in
    // Handle error
  }
}
```

## <span id="claim-orders">Claim Orders</span>

To claim an order for the current customer, the app should call the `claim` method.

```swift
// Create the customer info struct for person picking up (name is required)
let customerInfo = CustomerInfo(
  name: "Marty McFly",
  carType: "DeLorean",
  carColor: "Silver",
  licensePlate: "OUTATIME",
  phone: "555-555-5555"
)

FlyBuy.orders.claim(withRedemptionCode: code, customerInfo: customerInfo) { (order, error)
  // If error == nil, order has been claimed
}
```

**IMPORTANT:** Make sure to call `FlyBuy.orders.fetch()` to sync the orders after successfully claiming the order. The newly claimed order will appear in the list of open orders, which is available via `FlyBuy.orders.open`.

Optionally, the pickup type can be set when claiming an order. This is only necessary for apps that do not set the pickup type via backend integrations when the order is created. Supported pickup types currently include `"curbside"`, `"pickup"`, and `"delivery"`. Passing `nil` will leave the `pickupType` unchanged.

```swift
FlyBuy.orders.claim(withRedemptionCode: code, customerInfo: customerInfo, pickupType: pickupType) { (order, error)
  // If error == nil, order has been claimed
}
```

## <span id="create-orders">Create Orders</span>

Create an order by passing order identifiers to the `create` method. There are numerous attributes available, but not all fields are mandatory.

If you would like to pass the customer's phone number, provide a `phone` argument. If you do not have a phone number, provide an empty string `""`.

By default, orders are created with a state of `.created`. If you wish to provide a different `OrderState`, you can provide that optional argument. If you do not wish to provide a different state, omit the parameter.

Most orders will have a pickup time of "ASAP". If you have a different pickup window, you can pass a `pickupWindow` parameter. If you want the default of "ASAP", omit the parameter.

```swift
let customerInfo = CustomerInfo(
  name: "Marty McFly",
  carType: "DeLorean",
  carColor: "Silver",
  licensePlate: "OUTATIME",
  phone: "555-555-5555"
)

FlyBuy.orders.create(siteID: 101, partnerIdentifier: "1234123", customerInfo: customerInfo) { (order, error) -> (Void) in
  // Handle order or deal with error
}
```

To create a pickup window, you can pass a start time and an optional end time:

```swift
// Both start and end
window = PickupWindow(start: <start date/time here>, end: <end date/time here>)

// Just a start time
window = PickupWindow(<date/time here>)
```

## <span id="update-orders">Update Orders</span>

Orders are always updated with an order event. The order object cannot be updated directly.

### Update customer state

```swift
FlyBuy.orders.event(orderID: order.id, customerState: .waiting)

// Or with a block

FlyBuy.orders.event(orderID: order.id, customerState: .waiting) { (order, error) in
  // Handle event or deal with error
}
```

Refer to [Customer State ENUM Values](data_models.md#customer-state-enum-values) for possible `customerState` values.

### Update order state

You can update an order's state, if necessary, with any valid `OrderState` enum:

```swift
FlyBuy.orders.event(orderID: order.id, state: .cancelled)
```

Refer to [Order State ENUM Values](#order-state-enum-values) for possible `state` values.

## <span id="rate-orders">Customer Ratings</span>

If you collect customer ratings in your app, you can pass them to FlyBuy. The `rating` should be an integer and `comments` (optional) should be a string:

```swift
FlyBuy.orders.rateOrder(orderID: 123, rating: 5, comments: 'Great service')
```