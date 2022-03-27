# Titanium Web Dialog

Use the native `SFSafariViewController` (iOS) and `Chrome Pages` (Android) within Appcelerator Titanium.

<img src="./fixtures/example-screens.jpg" width="890" alt="Titanium Web Dialog" />

## Requirements

- Titanium SDK 9.0.0 or later
- iOS 9+ and Android 4.1+

## iOS Note

The iOS part of this module is based on Ti.SafariDialog, which has been deprecated for a cross-platform solution. All API's of Ti.SafariDialog
still work here and have been extended by more features over time.

## Android Note
In order to use the `close` event on Android it is recommended to have a short delay between `var WebDialog = require('ti.webdialog');` and `WebDialog.open({})`. Otherwise it might not fire the `close` event.

## API's

### Top-Level

#### Methods

* `open(arguments)`
    * `url` (String)
    * `barColor` (String)
    * `animated` (Boolean, iOS only)
    * `entersReaderIfAvailable` (Boolean, iOS only)
    * `barCollapsingEnabled` (Boolean)
    * `title` (String, iOS only)
    * `tintColor` (String, iOS only)
    * `dismissButtonStyle` (`DISMISS_BUTTON_STYLE_*`, iOS only)
    * `showTitle` (Boolean, Android only)
    * `fadeTransition` (Boolean, Android only)
    * `enableSharing` (Boolean, Android only) - Enable Share... menu item to share link
    * `closeIcon` (String, Android only) - image path to show as close-button icon

* `isSupported()` -> Boolean
* `isOpen()` (iOS only) -> Boolean
* `close()` (iOS only)

#### Properties

* `DISMISS_BUTTON_STYLE_DONE` (iOS only)
* `DISMISS_BUTTON_STYLE_CLOSE` (iOS only)
* `DISMISS_BUTTON_STYLE_CANCEL` (iOS only)

#### Events

* `open` -> `success` (Boolean), `url` (String)
* `close` -> `success` (Boolean), `url` (String)
* `load` -> `success` (Boolean), `url` (String) - iOS only
* `redirect` -> `url` (String) - iOS only

### `AuthenticationSession` (iOS only)

#### Methods

* `createAuthenticationSession(arguments)`
    * `url` (String)
    * `scheme` (String)

#### Events

* `callback` -> `success` (Boolean), `callbackURL` (String)

## License

Apache 2.0

## Author
- [Hans Knöchel](https://github.com/hansemannn)
- [Prashant Saini](https://github.com/prashantsaini1)
