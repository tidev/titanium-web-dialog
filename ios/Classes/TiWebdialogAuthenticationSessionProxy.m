/**
 * Ti.WebDialog
 *
 * Copyright (c) 2009-present by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiWebdialogAuthenticationSessionProxy.h"
#import <SafariServices/SafariServices.h>

@implementation TiWebdialogAuthenticationSessionProxy

- (ASWebAuthenticationSession *)authSession
{
  if (_authSession == nil) {
    NSString *url = [TiUtils stringValue:[self valueForKey:@"url"]];
    NSString *scheme = [TiUtils stringValue:[self valueForKey:@"scheme"]];

    _authSession = [[ASWebAuthenticationSession alloc] initWithURL:[TiUtils toURL:url proxy:self]
                                                 callbackURLScheme:scheme
                                                 completionHandler:^(NSURL *_Nullable callbackURL, NSError *_Nullable error) {
                                                   [self fireEventWithCallbackUrl:callbackURL andError:error];
                                                 }];
    
    _authSession.presentationContextProvider = self;
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
  [[self authSession] start];
}

- (void)cancel:(id)unused
{
  [[self authSession] cancel];
}

- (NSNumber *)isSupported:(id)unused
{
  return @(YES);
}

@end
