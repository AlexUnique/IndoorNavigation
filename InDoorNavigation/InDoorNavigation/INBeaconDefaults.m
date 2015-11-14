//
//  INBeaconDefaults.h
//  InDoorNavigation
//
//  Created by Alex Kalinichenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INBeaconDefaults.h"

NSString *BeaconIdentifier = @"com.example.apple-samplecode.AirLocate";


@implementation INBeaconDefaults

- (id)init
{
    self = [super init];
    if(self)
    {
        // uuidgen should be used to generate UUIDs.
        _supportedProximityUUIDs = @[[[NSUUID alloc] initWithUUIDString:@"11156DB5-DFFB-48D2-B060-D0F5A71096E0"],
                                      [[NSUUID alloc] initWithUUIDString:@"222BCFCE-174E-4BAC-A814-092E77F6B7E5"],
                                      [[NSUUID alloc] initWithUUIDString:@"33378BDA-B644-4520-8F0C-720EAF059935"],
                                     [[NSUUID alloc] initWithUUIDString:@"444E7901-873F-4F9C-88E5-ECD5F350434E"],
                                     [[NSUUID alloc] initWithUUIDString:@"55578BDA-B644-4520-8F0C-720EAF059935"],
                                     [[NSUUID alloc] initWithUUIDString:@"66678BDA-B644-4520-8F0C-720EAF059935"]];
        _defaultPower = @-59;
    }
    
    return self;
}


+ (INBeaconDefaults *)sharedDefaults
{
    static id sharedDefaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDefaults = [[self alloc] init];
    });
    
    return sharedDefaults;
}


- (NSUUID *)defaultProximityUUID
{
    return _supportedProximityUUIDs[0];
}

@end
