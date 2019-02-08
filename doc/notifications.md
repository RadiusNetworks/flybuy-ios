# FlyBuy SDK for iOS: Notifications

FlyBuy can leverage Apple's push notification service to get updates about the orders. FlyBuy does not perform the push notification directly, instead it relies on the app to notify it that a new notification has been received. If you do not already handle APNS in your app we recommend using a service like [Firebase](https://firebase.google.com).

To integrate this the following callbacks need to be defined in the `AppDelegate`.

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


