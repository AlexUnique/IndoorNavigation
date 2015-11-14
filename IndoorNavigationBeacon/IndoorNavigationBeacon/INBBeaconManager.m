//
//  INBBeaconManager.m
//  IndoorNavigationBeacon
//
//  Created by Alex Kalinichenko on 11/14/15.
//  Copyright © 2015 Alex Kalinichenko. All rights reserved.
//

#import "INBBeaconManager.h"

@interface INBBeaconManager ()
@property (nonatomic, strong) INBBeacon *activeBeacon;
@end

@implementation INBBeaconManager

///--------------------------------------------------
/// Lifecycle
///--------------------------------------------------
#pragma mark - Lifecycle

+ (instancetype)sharedManager
{
  static id sharedObject = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedObject = [self new];
  });
  
  return sharedObject;
}

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    
  }
  
  return self;
}


///--------------------------------------------------
/// Properties
///--------------------------------------------------
#pragma mark - Properties

- (CBPeripheralManager *)peripheralManager
{
  if (_peripheralManager == nil)
  {
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
  }
  
  return _peripheralManager;
}

///--------------------------------------------------
/// Manager Flow
///--------------------------------------------------
#pragma mark - Manager Flow

- (void)startAdvertisingBeacon:(INBBeacon *)beacon
{
  [self stop];
  
  self.activeBeacon = beacon;
  [self.peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey :
                                             @[self.activeBeacon.beaconService.UUID]}];
}

- (void)stop
{
  [self.peripheralManager stopAdvertising];
}


///--------------------------------------------------
/// CBPeripheralManager
///--------------------------------------------------
#pragma mark - CBPeripheralManager

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(nullable NSError *)error
{
  NSLog(@"peripheralManagerDidStartAdvertising:%@ error:%@", peripheral, error);
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
  if ([request.characteristic.UUID isEqual:self.activeBeacon.beaconIDCharacteristic.UUID])
  {
    CBCharacteristic *beaconIDCharacteristic = self.activeBeacon.beaconIDCharacteristic;

    if (request.offset > beaconIDCharacteristic.value.length)
    {
      [self.peripheralManager respondToRequest:request withResult:CBATTErrorInvalidOffset];
      return;
    }
    
    NSRange valueRange = NSMakeRange(request.offset, beaconIDCharacteristic.value.length - request.offset);
    request.value = [beaconIDCharacteristic.value subdataWithRange:valueRange];
    
    [self.peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
  }
}

@end
