# Titanium Web Dialog

Use the SFSafariViewController (iOS) and Chrome Pages (Android) together. Currently in development and scheduled 
as a pre-packaged module for Titanium SDK 7.1.0 and later.

<img src="./fixtures/DQM57Q7X4AAF8yR.jpg" width="800" alt="Titanium Web Dialog" />

## Roadmap

- [x] Find suitable module name
- [x] Create both modules on the same namespace (right now [Ti.SafariDialog](https://github.com/appcelerator-modules/ti.safaridialog) vs [Ti.ChromeTabs](https://github.com/prashantsaini1/ti-chrometabs))
- [x] Adjust existing docs from Ti.SafariDialog to support Android as well
- [x] Write cross-platform example and tests
- [ ] Pre-package in the SDK, release module

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
