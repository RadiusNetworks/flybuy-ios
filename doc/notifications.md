# Notifications

FlyBuy can leverage push notification services to send order or customer state updates via a payload.

```
{
	"message_source": "flybuy",
	"order_id": "1",
	"state": "created",
	"customer_state": "arrived",
	"eta_at": "2020-02-01T00:00:00.000Z"
}
```

FlyBuy does not perform push notifications directly to the app.
Any desired app push notifications must be handled appropriately within the app.

**Using a push service to receive order and customer updates is required.** FlyBuy is integrated with the following push notification service providers. If you are using a push service that is not listed, please contact your Customer Success representative.
- APNs (Apple Push Notification service)
- Firebase
- OneSignal
- Airship

Once your app receives a token for your push notification service, the token needs to be provided by calling `FlyBuy.updatePushToken()`. This allows your app to receive updates to the order information via push notification:

```swift
FlyBuy.updatePushToken("740f4707bebcf74f9b7c25d48e3358945f6aa01da5ddb387462c7eaf61bb78ad")
```

To integrate this functionality the following callbacks need to be defined in the `AppDelegate`.

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
  FlyBuy.handleRemoteNotification(userInfo)

  // Do other stuff...
  print(userInfo)
}
```

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
  FlyBuy.handleRemoteNotification(userInfo)

  // Do other stuff...
  print(userInfo)
}
```

```swift
func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
  let userInfo = notification.request.content.userInfo
  FlyBuy.handleRemoteNotification(userInfo)

  // Do other stuff...
  print(userInfo)
}
```

You do not need to filter or check the body of the `userInfo` data, FlyBuy will inspect it and only process the notification if it is relevant to the SDK.

## OneSignal integration

If your app uses OneSignal to send and receive push notifications, you will need to add the following code in your app delegate to receive the notification payload and send to the FlyBuy SDK:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

  // ...

  OneSignal.add(self as OSSubscriptionObserver)
  let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
    if let notification = notification {
      FlyBuy.handleRemoteNotification(notification.payload.additionalData)
    }
  }

  // Replace 'YOUR_APP_ID' with your OneSignal App ID.
  OneSignal.initWithLaunchOptions(
    launchOptions,
    appId: "YOUR_APP_ID",
    handleNotificationReceived: notificationReceivedBlock,
    handleNotificationAction: nil,
    settings: onesignalInitSettings
  )

  // get userId to give to FlyBuy SDK
  if let userId = OneSignal.getPermissionSubscriptionState().subscriptionStatus.userId {
    FlyBuy.updatePushToken(userId)
  }

  // ...
}

extension AppDelegate : OSSubscriptionObserver {
  func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges!) {
    if let playerId = stateChanges.to.userId {
      // send updated userId to FlyBuy SDK
      FlyBuy.updatePushToken(playerId)
    }
  }
}

```
