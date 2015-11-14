//
//  INBeacon.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INBeacon.h"

@implementation INBeacon

- (instancetype)initWithCLBeacon:(CLBeacon *)locationBeacon
{
  NSParameterAssert(locationBeacon != nil);
  
  self = [super init];
  
  if (self != nil)
  {
    _locationBeacon = locationBeacon;
  }
  
  return self;
}


///--------------------------------------------------
/// Properties
///--------------------------------------------------
#pragma mark - Properties

- (void)setLocationBeacon:(CLBeacon *)locationBeacon
{
  NSAssert([locationBeacon.proximityUUID isEqual:self.UUID], @"CLBeacon.proximityUUID must be equal to INBeacon.UUID");
  _locationBeacon = locationBeacon;
}

- (NSUUID *)UUID
{
  return self.locationBeacon.proximityUUID;
}

@end
