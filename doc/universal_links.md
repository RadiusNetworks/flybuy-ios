# Universal Links

These instructions will help you set up universal links to your iOS app from a white-label FlyBuy domain.  If you don't already have a white-label domain set up with FlyBuy go [here](https://github.com/RadiusNetworks/flybuy-documentation/blob/master/doc/white_label_domains.md) to get that set up first.

## Setting up universal links in your app from a white-label FlyBuy domain

To get started we need a few things to set up your white-label FlyBuy domain to support directing users to your app via iOS universal links:

- The name of the existing white-label FlyBuy domain to set up for your app (e.g., `pickup.example.com`)
- The link to the app in the App Store
- The Apple "App ID Prefix" for the app (e.g, `ABCDE12345`)
- The "Bundle ID" for the app (e.g., `com.example.MyApp`)

The App ID Prefix and Bundle ID for the app can be found in the [Apple developer console](https://developer.apple.com).  Under the "Certificates, Identifiers & Profiles" section go to "Identifiers" and click on the row for your app.  This page should show both the App ID Prefix and Bundle ID for the app.

Please provide this info to your account rep to get started, next you'll just need to set up your app to receive universal links from the white-label FlyBuy domain.

### Add an entitlement that specifies the white-label domain your app will support

In Xcode, go to the "Capabilities" tab for your app target.  Toggle the "Associated Domains" capability so it's turned on and add an `applinks` domain entry to the list of "Domains" for your white-label domain.  It should look something like this:

```
applinks:pickup.example.com
```


### Update your app delegate to respond appropriately to the universal link

After adding the associated domain, add the `UIApplicationDelegate` method for handling incoming universal links ([`application:continueUserActivity:restorationHandler:`](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623072-application)) to your `AppDelegate`.  Specifically you are looking for the `NSUserActivityTypeBrowsingWeb` activity type which represents an incoming universal link.  For this case the `userActivity.webpageURL` represents the URL that the user tapped.  Here's an example code snippet that will log incoming universal link URLs:

```swift
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
      let incomingURL = userActivity.webpageURL else {
        return false
    }

    NSLog("Responding to universal link with URL: \(incomingURL)")
    return true
  }
```

The important part of the incoming URL is the order redemption code, stored in the `r` query parameter of the URL (e.g., `https://pickup.example.com/m/o?r=CODE`).  You can pull the redemption code from the URL and call the `FlyBuy.orders.fetch(withRedemptionCode: redemptionCode)` function to retrieve the order from the FlyBuy SDK and take appropriate action for the universal link.
