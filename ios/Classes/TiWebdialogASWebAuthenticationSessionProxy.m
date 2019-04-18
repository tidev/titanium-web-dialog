/**
 * Ti.WebDialog
 *
 * Copyright (c) 2009-present by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#if IS_IOS_12

#import "TiWebdialogASWebAuthenticationSessionProxy.h"
#import "TiUtils.h"

@implementation TiWebdialogASWebAuthenticationSessionProxy

- (ASWebAuthenticationSession *)authSession
{
  if (_authSession == nil) {
    NSString *url = [TiUtils stringValue:[self valueForKey:@"url"]];
    NSString *scheme = [TiUtils stringValue:[self valueForKey:@"scheme"]];

    _authSession = [[ASWebAuthenticationSession alloc] initWithURL:[TiUtils toURL:url proxy:self]
                                              callbackURLScheme:[TiUtils stringValue:scheme]
                                              completionHandler:^(NSURL *callbackURL, NSError *error) {
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
                                              }];
  }

  return _authSession;
}

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
  return NUMBOOL([TiUtils isIOSVersionOrGreater:@"12.0"]);
}

@end

#endif
