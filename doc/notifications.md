# Notifications

FlyBuy can leverage Apple's Push Notification Service (APNS) to get updates about the status of an order. FlyBuy does not perform the push notification directly, instead it relies on the app to notify it that a new notification has been received. If you do not already handle APNS in your app we recommend using a service like [Firebase](https://firebase.google.com).

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
