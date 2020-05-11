/**
 * Ti.WebDialog
 *
 * Copyright (c) 2009-present by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiWebdialogAuthenticationSessionProxy.h"
#import "TiUtils.h"
#import <SafariServices/SafariServices.h>

@implementation TiWebdialogAuthenticationSessionProxy

- (id)authSession
{
  if (_authSession == nil) {
    NSString *url = [TiUtils stringValue:[self valueForKey:@"url"]];
    NSString *scheme = [TiUtils stringValue:[self valueForKey:@"scheme"]];

    if ([TiUtils isIOSVersionOrGreater:@"12.0"]) {
      _authSession = [[ASWebAuthenticationSession alloc] initWithURL:[TiUtils toURL:url proxy:self]
                                                   callbackURLScheme:scheme
                                                   completionHandler:^(NSURL *_Nullable callbackURL, NSError *_Nullable error) {
                                                     [self fireEventWithCallbackUrl:callbackURL andError:error];
                                                   }];
#if IS_IOS_13
      if ([TiUtils isIOSVersionOrGreater:@"13.0"]) {
        ((ASWebAuthenticationSession *)_authSession).presentationContextProvider = self;
      }
#endif
    } else {
      _authSession = [[SFAuthenticationSession alloc] initWithURL:[TiUtils toURL:url proxy:self]
                                                callbackURLScheme:scheme
                                                completionHandler:^(NSURL *callbackURL, NSError *error) {
                                                  [self fireEventWithCallbackUrl:callbackURL andError:error];
                                                }];
    }
  }

  return _authSession;
}

- (void)fireEventWithCallbackUrl:(NSURL *)callbackURL andError:(NSError *)error
{
  NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{
    @"success" : NUMBOOL(error == nil)
  }];

  if (error != nil) {
    [event setObject:[error localizedDescription] forKey:@"error"];
  } else {
    [event setObject:[callbackURL absoluteString] forKey:@"callbackURL"];
  }

  if ([self _hasListeners:@"callback"]) {
    [self fireEvent:@"callback" withObject:event];
  }
}

#pragma mark Delegate method

#if IS_IOS_13
- (ASPresentationAnchor)presentationAnchorForWebAuthenticationSession:(ASWebAuthenticationSession *)session
{
  return [[UIApplication sharedApplication] keyWindow];
}
#endif

#pragma mark Public API's

- (void)start:(id)unused
{
  id session = [self authSession];
  if ([session isKindOfClass:[SFAuthenticationSession class]]) {
    [(SFAuthenticationSession *)session start];
  } else if ([session isKindOfClass:[ASWebAuthenticationSession class]]) {
    [(ASWebAuthenticationSession *)session start];
  }
}

- (void)cancel:(id)unused
{
  [[self authSession] cancel];
}

- (NSNumber *)isSupported:(id)unused
{
  return NUMBOOL([TiUtils isIOSVersionOrGreater:@"11.0"]);
}

@end
