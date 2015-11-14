//
//  INBBeaconDiscoveryManager.m
//  IndoorNavigationBeacon
//
//  Created by Alex Kalinichenko on 11/14/15.
//  Copyright © 2015 Alex Kalinichenko. All rights reserved.
//

#import "INBBeaconDiscoveryManager.h"

@implementation INBBeaconDiscoveryManager

///--------------------------------------------------
/// Lifecycle
///--------------------------------------------------
#pragma mark - Lifecycle

+ (instancetype)sharedManager
{
  static id sharedManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedManager = [self new];
  });
  
  return sharedManager;
}


///--------------------------------------------------
/// Properties
///--------------------------------------------------
#pragma mark - Properties

- (CBCentralManager *)centralManager
{
  if (_centralManager == nil)
  {
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
  }
  
  return _centralManager;
}


///--------------------------------------------------
/// Manager Flow
///--------------------------------------------------
#pragma mark - Manager Flow



@end
