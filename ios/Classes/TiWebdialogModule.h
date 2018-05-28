/**
 * Ti.WebDialog
 *
 * Copyright (c) 2009-present by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiModule.h"
#import <SafariServices/SafariServices.h>

@interface TiWebdialogModule : TiModule <SFSafariViewControllerDelegate> {
  @private
  SFSafariViewController *_safariController;
  NSString *_url;
  BOOL _isOpen;
}

- (NSNumber *)isOpen:(id __unused)unused;

- (NSNumber *)isSupported:(id __unused)unused;

- (void)close:(id __unused)unused;

- (void)open:(id)args;

@end
