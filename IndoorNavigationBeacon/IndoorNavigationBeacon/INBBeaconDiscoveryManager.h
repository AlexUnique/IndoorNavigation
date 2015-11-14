//
//  INBBeaconDiscoveryManager.h
//  IndoorNavigationBeacon
//
//  Created by Alex Kalinichenko on 11/14/15.
//  Copyright © 2015 Alex Kalinichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface INBBeaconDiscoveryManager : NSObject <CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;

+ (instancetype)sharedManager;

- (void)startDiscovering;

@end
