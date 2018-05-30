/**
 * Ti.WebDialog
 *
 * Copyright (c) 2009-present by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#if IS_IOS_11

#import "TiProxy.h"
#import <SafariServices/SafariServices.h>

@interface TiWebdialogAuthenticationSessionProxy : TiProxy {
  SFAuthenticationSession *_authSession;
}

#pragma mark Public API's

- (void)start:(id)unused;

- (void)cancel:(id)unused;

- (NSNumber *)isSupported:(id)unused;

@end

#endif
