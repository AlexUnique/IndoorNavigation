//
//  INBBeacon.m
//  IndoorNavigationBeacon
//
//  Created by Alex Kalinichenko on 11/14/15.
//  Copyright © 2015 Alex Kalinichenko. All rights reserved.
//

#import "INBBeacon.h"

@implementation INBBeacon

///--------------------------------------------------
/// Class Properties
///--------------------------------------------------
#pragma mark - Class Properties

+ (CBUUID *)serviceUUID
{
  static CBUUID *serviceUUID = nil;
  
  if (serviceUUID == nil)
  {
    serviceUUID = [CBUUID UUIDWithString:@"4E1F2E00-0B2E-4E67-9164-1186B3E0903B"];
  }
  
  return serviceUUID;
}

+ (CBUUID *)beaconIDCharacteristicUUID
{
  static CBUUID *characticUUID = nil;
  
  if (characticUUID == nil)
  {
    characticUUID = [CBUUID UUIDWithString:@"772E7901-873F-4F9C-88E5-ECD5F350434E"];
  }
  
  return characticUUID;
}


///--------------------------------------------------
/// Lifecycle
///--------------------------------------------------
#pragma mark - Lifecycle

- (instancetype)initWithUUID:(NSUUID *)UUID
{
  self = [super init];
  
  if (self != nil)
  {
    NSParameterAssert(UUID != nil);
    _UUID = UUID;
  }
  
  return self;
}

- (void)_configureServices
{
  self.beaconIDCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[self.class beaconIDCharacteristicUUID]
                                                                   properties:CBCharacteristicPropertyRead
                                                                        value:[self.UUID.UUIDString dataUsingEncoding:NSUTF8StringEncoding]
                                                                  permissions:CBAttributePermissionsReadable];
  
  self.beaconService = [[CBMutableService alloc] initWithType:[self.class serviceUUID] primary:YES];
  self.beaconService.characteristics = @[self.beaconIDCharacteristic];
}

@end
