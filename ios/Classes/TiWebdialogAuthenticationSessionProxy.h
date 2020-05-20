/**
 * Ti.WebDialog
 *
 * Copyright (c) 2009-present by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiProxy.h"
#import <AuthenticationServices/AuthenticationServices.h>

#if IS_IOS_13
@interface TiWebdialogAuthenticationSessionProxy : TiProxy <ASWebAuthenticationPresentationContextProviding>
#else
@interface TiWebdialogAuthenticationSessionProxy : TiProxy
#endif
{
  id _authSession;
}

#pragma mark Public API's

- (void)start:(id)unused;

- (void)cancel:(id)unused;

- (NSNumber *)isSupported:(id)unused;

@end
