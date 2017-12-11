# Titanium Web Dialog

Use the SFSafariViewController (iOS) and Chrome Pages (Android) together. Currently in development and scheduled 
as a pre-packaged module for Titanium SDK 7.1.0 and later.

<img src="./fixtures/DQM57Q7X4AAF8yR.jpg" width="890" alt="Titanium Web Dialog" />

## Requirements

- Titanium SDK 7.0.0 or later (or use the [SDK-6-compatibility](https://github.com/appcelerator-modules/titanium-web-dialog/tree/SDK-6-compatibility) Titanium SDK 6.x)
- iOS 9 and Android 4.1

## Roadmap

- [x] Find suitable module name
- [x] Create both modules on the same namespace (right now [Ti.SafariDialog](https://github.com/appcelerator-modules/ti.safaridialog) vs [Ti.ChromeTabs](https://github.com/prashantsaini1/ti-chrometabs))
- [x] Adjust existing docs from Ti.SafariDialog to support Android as well
- [x] Write cross-platform example and tests
- [ ] Pre-package in the SDK, release module

## Android Legacy Support

This module is designed to work with the latest platform API's that are covered by the Titanium SDK 7.0.0 and later.
If you want to use this module in Titanium SDK 6.x, please use the [this version](https://github.com/appcelerator-modules/titanium-web-dialog/raw/SDK-6-compatibility/android/legacy/ti.webdialog-android-1.0.0.zip).

## API's

### Top-Level

#### Methods

* `open(arguments)`
    * `url` (String)
    * `barColor` (String)
    * `animated` (Boolean, iOS only)
    * `entersReaderIfAvailable` (Boolean, iOS only)
    * `barCollapsingEnabled` (Boolean, iOS only)
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

### `AuthenticationSession` (iOS only)

## License

Apache 2.0

## Author
- [Hans Knöchel](https://github.com/hansemannn)
- [Prashant Saini](https://github.com/prashantsaini1)
