# Orders

Examples are in Swift.

- [Fetch Claimed Orders](#fetch-claimed-orders)
- [Fetch Unclaimed Orders](#fetch-unclaimed-orders)
- [Observe Orders](#observe-orders)
- [Claim Orders](#claim-orders)
- [Create Orders](#create-orders)
- [Update Orders](#update-orders)
- [Rate Orders](#rate-orders)

## <span id="fetch-claimed-orders">Fetch Claimed Orders</span>

Fetch the latest claimed orders with the server. An order is claimed if it is associated with the current customer.

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

## <span id="fetch-unclaimed-orders">Fetch Unclaimed Orders</span>

```swift
FlyBuy.orders.fetch(withRedemptionCode: code) { (order, error)
  // Update order claim view with order details here
}
```

## <span id="observe-orders">Observe Orders</span>

Set up observers to get updates about orders.

Fetching the orders will broadcast `NSNotifications` as updates are received. You can add a method like `registerForNotifications()` in a view controller and call it from `viewDidLoad()`.

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
let customerInfo = CustomerInfo(
  name: "Bob Smith",
  carType: "Honda Civic",
  carColor: "white",
  licensePlate: "ABC-123",
  phone: "555-5555"
)

FlyBuy.orders.claim(withRedemptionCode: code, customerInfo: customerInfo) { (order, error)
  // If error == nil, order has been claimed
}
```

After an order is claimed, call `FlyBuy.orders.fetch()` to update the list of orders from the server. The newly claimed order will appear in the list of open orders, which is available via `FlyBuy.orders.open`.

## <span id="create-orders">Create Orders</span>

Create an order by passing order identifiers to the `create` method. There are numerous attributes available, but not all fields are mandatory.

If you would like to pass the customer's phone number, provide a `phone` argument. If you do not have a phone number, provide an empty string `""`.

By default, orders are created with a state of `.created`. If you wish to provide a different `OrderState`, you can provide that optional argument. If you do not wish to provide a different state, omit the parameter.

Most orders will have a pickup time of "ASAP". If you have a different pickup window, you can pass a `pickupWindow` parameter. If you want the default of "ASAP", omit the parameter.

```swift
let customerInfo = CustomerInfo(
  name: "Bob Smith",
  carType: "Honda Civic",
  carColor: "white",
  licensePlate: "ABC-123",
  phone: "555-5555"
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

```swift
FlyBuy.orders.event(orderID: order.id, customerState: .waiting)

// Or with a block

FlyBuy.orders.event(orderID: order.id, customerState: .waiting) { (order, error) in
  // Handle event or deal with error
}
```

You can update an order's state, if necessary, with any valid `OrderState` enum:

```swift
FlyBuy.orders.event(orderID: order.id, state: .cancelled)
```

## <span id="rate-orders">Customer Ratings</span>

If you collect customer ratings in your app, you can pass them to FlyBuy. The `rating` should be an integer and `comments` (optional) should be a string:

```swift
FlyBuy.orders.rateOrder(orderID: 123, rating: 5, comments: 'Great service')
```

## Customer State ENUM Values

| Value       | Description                                                             |
|-------------|-------------------------------------------------------------------------|
| `created`   | Customer has claimed their order                                        |
| `enRoute`   | Order tracking has started and the customer is on their way             |
| `nearby`    | Customer is close to the site                                           |
| `arrived`   | Customer has arrived on site                                            |
| `waiting`   | Customer is in a pickup area or has manually indicated they are waiting |
| `completed` | Order is complete                                                       |


## Order State ENUM Values

| Value       | Description                                                             |
|-------------|-------------------------------------------------------------------------|
| `created`   | Order has been created                                                  |
| `ready`     | Order is ready for customer to claim                                    |
| `delayed`   | Order has been delayed by merchant after customer arrives               |
| `cancelled` | Merchant has cancelled order                                            |
| `completed` | Order is complete                                                       |
| `gone`      | Returned by API when order does not exist                               |
