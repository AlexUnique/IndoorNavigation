//
//  INBeacon.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface INBeacon : NSObject

@property (nonatomic, readonly) NSUUID *UUID;
@property (nonatomic, strong) CLBeacon *locationBeacon;

- (instancetype)initWithCLBeacon:(CLBeacon *)locationBeacon;

@end
