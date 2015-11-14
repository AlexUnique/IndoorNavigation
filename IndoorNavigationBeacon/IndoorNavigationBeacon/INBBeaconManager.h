//
//  INBBeaconManager.h
//  IndoorNavigationBeacon
//
//  Created by Alex Kalinichenko on 11/14/15.
//  Copyright © 2015 Alex Kalinichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "INBBeacon.h"

@interface INBBeaconManager : NSObject <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, readonly) INBBeacon *activeBeacon;

+ (instancetype)sharedManager;

- (void)startAdvertisingBeacon:(INBBeacon *)beacon;

@end
