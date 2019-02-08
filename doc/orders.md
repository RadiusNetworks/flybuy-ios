# FlyBuy SDK for iOS: Orders

## Fetching Orders

Allows fetching the list of orders, creating a new order, or creating order events.

```swift
FlyBuy.orders.fetch()
```

Fetching the orders will broadcast `NSNotifications` as updates are received. In order to get the update observers should watch for updates. For example in a view controller you might add a method like `registerForNotifications()` and call it from `viewDidLoad()`

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

## List Orders

Once orders have been fetched they can be accessed via the `all` or `open` attributes.

```swift
FlyBuy.orders.all
FlyBuy.orders.open
```

`all` will return both open and closed orders. `open` will only return orders that are in progress.


## Create Order

```swift
let info = CreateOrderInfo(
  siteID: 101,
  partnerIdentifier: "ABC-123",
  customerCarColor: "#FF9900",
  customerCarType: "Silver Sedan",
  customerLicensePlate: "XYZ-456",
  customerName: customerName
)

FlyBuy.orders.create(info: info) { (order, error) -> (Void) in
  // Handle order or deal with error
}
```

#### Order Info attributes

| Attribute              | Description                                     |
| ---------------------- | ----------------------------------------------- |
| `siteID`               | The FlyBuy Site Identifier                      |
| `partnerIdentifier`    | Internal identifier for app developer reference |
| `customerCarColor`     | Color of the customer's vehicle                 |
| `customerCarType`      | Make and model of the customer's vehicle        |
| `customerLicensePlate` | License plate of the customer's vehicle         |
| `customerName`         | Customer's name                                 |

## Updating Orders

Orders are always updated with an Order Event.

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

#### Order Event attributes

| Attribute | Description            |
| --------- | ---------------------- |
| `order` | The order data |
| `customerState` | Customer state ENUM value |

#### Customer State values

| Value       | Description                                                         |
| ----------- | ------------------------------------------------------------------- |
| `created`   | Order has been created                                              |
| `enRoute`   | Order tracking is started the customer is on their way              |
| `nearby`    | The customer is close to the site                                   |
| `arrived`   | The customer has arrived on premises                                |
| `waiting`   | The customer is in a pickup area or manually said they were waiting |
| `completed` | The order is complete                                               |

