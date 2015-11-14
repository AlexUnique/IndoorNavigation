//
//  INBeaconDiscoveryManager.h
//  InDoorNavigation
//
//  Created by Alex Kalinichenko on 11/14/15.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INBeacon.h"

extern NSString * const INBeaconDiscoveryManagerDidUpdateDiscoveredBeacons;

@interface INBeaconDiscoveryManager : NSObject

@property (nonatomic, readonly) NSArray *discoveredBeacons;
@property (nonatomic, readonly) INBeacon *nearestBeacon;

+ (instancetype)sharedManager;

- (void)startDiscovering;
- (NSArray *)beaconsWithProximity:(CLProximity)proximity;

@end
