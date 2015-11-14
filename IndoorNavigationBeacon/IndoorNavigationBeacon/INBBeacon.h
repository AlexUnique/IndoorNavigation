//
//  INBBeacon.h
//  IndoorNavigationBeacon
//
//  Created by Alex Kalinichenko on 11/14/15.
//  Copyright © 2015 Alex Kalinichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface INBBeacon : NSObject

@property (nonatomic, strong) NSUUID *UUID;
@property (nonatomic, strong) CBMutableService *beaconService;
@property (nonatomic, strong) CBMutableCharacteristic *beaconIDCharacteristic;

+ (CBUUID *)serviceUUID;
+ (CBUUID *)beaconIDCharacteristicUUID;

- (instancetype)initWithUUID:(NSUUID *)UUID;

@end
