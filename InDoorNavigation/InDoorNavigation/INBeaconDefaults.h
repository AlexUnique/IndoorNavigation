//
//  INBeaconDefaults.h
//  InDoorNavigation
//
//  Created by Alex Kalinichenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

@import Foundation;

extern NSString *BeaconIdentifier;

@interface INBeaconDefaults : NSObject

+ (INBeaconDefaults *)sharedDefaults;

@property (nonatomic, copy, readonly) NSArray *supportedProximityUUIDs;

@property (nonatomic, copy, readonly) NSUUID *defaultProximityUUID;
@property (nonatomic, copy, readonly) NSNumber *defaultPower;

@end
