# Orders

Examples are in Swift.

- [Fetch Claimed Orders](#fetch-claimed-orders)
- [Fetch Unclaimed Orders](#fetch-unclaimed-orders)
- [Observe Orders](#observe-orders)
- [Claim Orders](#claim-orders)
- [Update Orders](#update-orders)

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
let info = ClaimOrderInfo(
    customerCarColor: "Blue",
    customerCarType: "Chevy Tahoe",
    customerLicensePlate: "ABC-123",
    customerName: "Brian Johnson",
    pushToken: "TOKEN_HERE"
)

let consent = CustomerConsent(
    termsOfService: true,
    ageVerification: true
)

FlyBuy.orders.claim(withRedemptionCode: code, claimOrderInfo: info, customerConsent: consent) { (order, error)
    // If error == nil, order has been claimed
}
```

After an order is claimed, call `FlyBuy.orders.fetch()` to update the list of orders from the server. The newly claimed order will appear in the list of open orders, which is available via `FlyBuy.orders.open`.

## <span id="update-orders">Update Orders</span>

Orders are always updated with an order event. The order object cannot be updated directly.

```swift
let event = OrderEvent(
    order: order,
    customerState: .waiting
)

FlyBuy.orders.event(info: event)

// Or with a block
FlyBuy.orders.event(info: event) { (order, error) in
    // Handle event or deal with error
}
```

#### Order Event Attributes

| Attribute       | Description               |
|-----------------|---------------------------|
| `order`         | Order data                |
| `customerState` | Customer state ENUM value |

#### Customer State ENUM Values

| Value       | Description                                                             |
|-------------|-------------------------------------------------------------------------|
| `created`   | Order has been created                                                  |
| `enRoute`   | Order tracking has started and the customer is on their way             |
| `nearby`    | Customer is close to the site                                           |
| `arrived`   | Customer has arrived on site                                            |
| `waiting`   | Customer is in a pickup area or has manually indicated they are waiting |
| `completed` | Order is complete                                                       |