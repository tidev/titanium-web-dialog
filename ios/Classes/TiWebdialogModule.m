/**
 * Ti.WebDialog
 *
 * Copyright (c) 2009-present by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiWebdialogModule.h"
#import "TiApp.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiWebdialogModule

#pragma mark Internal

- (id)moduleGUID
{
  return @"1f19cce1-0ad7-4e25-ab3b-0666f54a0a49";
}

- (NSString *)moduleId
{
  return @"ti.webdialog";
}

#pragma mark Lifecycle

- (void)startup
{
  _isOpen = NO;
  [super startup];
}

#pragma mark internal methods

- (void)teardown
{
  if (_safariController != nil) {
    [_safariController setDelegate:nil];
    _safariController = nil;
  }

  _isOpen = NO;

  if ([self _hasListeners:@"close"]) {
    [self fireEvent:@"close"
         withObject:@{
           @"success" : NUMINT(YES),
           @"url" : [_url stringByRemovingPercentEncoding]
         }];
  }
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
  [self teardown];
}

- (SFSafariViewController *)safariController:(NSString *)url withEntersReaderIfAvailable:(BOOL)entersReaderIfAvailable andBarCollapsingEnabled:(BOOL)barCollapsingEnabled
{
  if (_safariController == nil) {
    NSURL *safariURL = [NSURL URLWithString:[url stringByRemovingPercentEncoding]];
    SFSafariViewControllerConfiguration *config = [[SFSafariViewControllerConfiguration alloc] init];
    config.entersReaderIfAvailable = entersReaderIfAvailable;
    config.barCollapsingEnabled = barCollapsingEnabled;

    _safariController = [[SFSafariViewController alloc] initWithURL:safariURL
                                                      configuration:config];
    [_safariController setDelegate:self];
  }

  return _safariController;
}

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
  if ([self _hasListeners:@"load"]) {
    [self fireEvent:@"load"
         withObject:@{
           @"url" : [_url stringByRemovingPercentEncoding],
           @"success" : NUMBOOL(didLoadSuccessfully)
         }];
  }
}

- (void)safariViewController:(SFSafariViewController *)controller initialLoadDidRedirectToURL:(NSURL *)URL
{
  if ([self _hasListeners:@"redirect"]) {
    [self fireEvent:@"redirect"
         withObject:@{
           @"url" : [_url stringByRemovingPercentEncoding]
         }];
  }
}

#pragma Public APIs

- (NSNumber *)isOpen:(id)unused
{
  return NUMBOOL(_isOpen);
}

- (NSNumber *)isSupported:(id)unused
{
  return NUMBOOL([TiUtils isIOSVersionOrGreater:@"9.0"]);
}

- (void)close:(id)unused
{
  ENSURE_UI_THREAD(close, unused);

  if (_safariController != nil) {
    [[TiApp app] hideModalController:_safariController animated:YES];
    [self teardown];
  }
  _isOpen = NO;
}

- (void)open:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary);
  ENSURE_UI_THREAD(open, args);

  if (![args objectForKey:@"url"]) {
    NSLog(@"[ERROR] url is required");
    return;
  }

  _url = [TiUtils stringValue:@"url" properties:args];
  BOOL animated = [TiUtils boolValue:@"animated" properties:args def:YES];
  BOOL entersReaderIfAvailable = [TiUtils boolValue:@"entersReaderIfAvailable" properties:args def:YES];
  BOOL barCollapsingEnabled = NO;

  barCollapsingEnabled = [TiUtils boolValue:@"barCollapsingEnabled" properties:args def:YES];

  SFSafariViewController *safari = [self safariController:_url withEntersReaderIfAvailable:entersReaderIfAvailable andBarCollapsingEnabled:barCollapsingEnabled];

  if ([args objectForKey:@"title"]) {
    [safari setTitle:[TiUtils stringValue:@"title" properties:args]];
  }

  if ([args objectForKey:@"tintColor"]) {
    TiColor *newColor = [TiUtils colorValue:@"tintColor" properties:args];
    [safari setPreferredControlTintColor:[newColor _color]];
  }

  if ([args objectForKey:@"barColor"]) {
    [safari setPreferredBarTintColor:[[TiUtils colorValue:@"barColor" properties:args] _color]];
  }

  if ([args objectForKey:@"dismissButtonStyle"]) {
    [safari setDismissButtonStyle:[TiUtils intValue:@"dismissButtonStyle" properties:args def:SFSafariViewControllerDismissButtonStyleDone]];
  }

  [[TiApp app] showModalController:safari
                          animated:animated];

  _isOpen = YES;

  if ([self _hasListeners:@"open"]) {
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
                                            NUMINT(YES), @"success",
                                        _url, @"url",
                                        nil];
    [self fireEvent:@"open" withObject:event];
  }
}

#pragma mark Constants

MAKE_SYSTEM_PROP(DISMISS_BUTTON_STYLE_DONE, SFSafariViewControllerDismissButtonStyleDone);
MAKE_SYSTEM_PROP(DISMISS_BUTTON_STYLE_CLOSE, SFSafariViewControllerDismissButtonStyleClose);
MAKE_SYSTEM_PROP(DISMISS_BUTTON_STYLE_CANCEL, SFSafariViewControllerDismissButtonStyleCancel);

@end
