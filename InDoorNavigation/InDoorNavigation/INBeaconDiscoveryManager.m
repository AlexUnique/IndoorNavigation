//
//  INBeaconDiscoveryManager.m
//  InDoorNavigation
//
//  Created by Alex Kalinichenko on 11/14/15.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INBeaconDiscoveryManager.h"
#import "INBeaconDefaults.h"
@import CoreLocation;

NSString * const INBeaconDiscoveryManagerDidUpdateDiscoveredBeacons = @"INBeaconDiscoveryManagerDidUpdateDiscoveredBeacons";

@interface INBeaconDiscoveryManager () <CLLocationManagerDelegate>
@property (nonatomic, strong) NSMutableDictionary *beaconsIndexByUUID;
@property (nonatomic, strong) NSMutableDictionary *beaconsIndexByProximity;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *rangedRegions;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation INBeaconDiscoveryManager

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


///--------------------------------------------------
/// Properties
///--------------------------------------------------
#pragma mark - Properties

- (CLLocationManager *)locationManager
{
  if (_locationManager == nil)
  {
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
  }
  
  return _locationManager;
}

- (NSMutableDictionary *)rangedRegions
{
  if (_rangedRegions == nil)
  {
    _rangedRegions = [NSMutableDictionary new];
    
    for (NSUUID *uuid in [INBeaconDefaults sharedDefaults].supportedProximityUUIDs)
    {
      CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:[uuid UUIDString]];
      self.rangedRegions[region] = [NSArray array];
    }
  }
  
  return _rangedRegions;
}

- (NSMutableDictionary *)beaconsIndexByUUID
{
  if (_beaconsIndexByUUID == nil)
  {
    _beaconsIndexByUUID = [NSMutableDictionary new];
  }
  
  return _beaconsIndexByUUID;
}

- (NSMutableDictionary *)beaconsIndexByProximity
{
  if (_beaconsIndexByProximity == nil)
  {
    _beaconsIndexByProximity = [NSMutableDictionary new];
  }
  
  return _beaconsIndexByProximity;
}

- (NSArray *)discoveredBeacons
{
  return self.beaconsIndexByProximity.allValues;
}

- (INBeacon *)nearestBeacon
{
  NSPredicate *knownProximityPredicate = [NSPredicate predicateWithFormat:@"locationBeacon.proximity != %d", CLProximityUnknown];
  NSArray *beaconsInKnownProximity = [self.beaconsIndexByUUID.allValues filteredArrayUsingPredicate:knownProximityPredicate];
  
  NSSortDescriptor *accuracySortDescription = [NSSortDescriptor sortDescriptorWithKey:@"locationBeacon.accuracy" ascending:YES];
  NSArray *sortedBeacons = [beaconsInKnownProximity sortedArrayUsingDescriptors:@[accuracySortDescription]];

  return sortedBeacons.firstObject;
}


///--------------------------------------------------
/// Discovery Management
///--------------------------------------------------
#pragma mark - Discovery Management

- (void)startDiscovering
{
  [self.locationManager requestWhenInUseAuthorization];
}

- (void)_locationManagerDidChangeAuthorizationStatusToWhenInUse
{
  for (CLBeaconRegion *region in self.rangedRegions)
  {
    [self.locationManager startRangingBeaconsInRegion:region];
  }
  
  [self _startBeaconsUpdateNotificationTimer];
}

- (void)stopDiscovering
{
  [self _stopBeaconsUpdateNotificationTimer];
  
  for (CLBeaconRegion *region in self.rangedRegions)
  {
    [self.locationManager stopRangingBeaconsInRegion:region];
  }
}


///--------------------------------------------------
/// Notifications Management
///--------------------------------------------------
#pragma mark - Notifications Management

- (void)_startBeaconsUpdateNotificationTimer
{
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(_timerDidFire) userInfo:nil repeats:YES];
}

- (void)_stopBeaconsUpdateNotificationTimer
{
  if (self.timer.isValid)
  {
    [self.timer invalidate];
    self.timer = nil;
  }
}

- (void)_timerDidFire
{
  [self _postBeaconsDidUpdateNotification];
}

- (void)_postBeaconsDidUpdateNotification
{
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:INBeaconDiscoveryManagerDidUpdateDiscoveredBeacons
                                                        object:self];
    
  });
}


///--------------------------------------------------
/// Beacons Management
///--------------------------------------------------
#pragma mark - Beacons Management

- (NSArray *)beaconsWithProximity:(CLProximity)proximity
{
  return self.beaconsIndexByProximity[@(proximity)];
}

- (INBeacon *)_beaconWithUUID:(NSUUID *)UUID
{
  return self.beaconsIndexByUUID[UUID];
}

- (void)_setBeacon:(INBeacon *)beacon forUUID:(NSUUID *)UUID
{
  if (beacon == nil)
  {
    [self.beaconsIndexByUUID removeObjectForKey:UUID];
  }
  else
  {
    self.beaconsIndexByUUID[UUID] = beacon;
  }
}


///--------------------------------------------------
/// CLLocationManagerDelegate
///--------------------------------------------------
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
  NSLog(@"%@, status: %d", manager, (int)status);
  
  if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
  {
    [self _locationManagerDidChangeAuthorizationStatusToWhenInUse];
  }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
  NSAssert([NSThread currentThread].isMainThread, @"Not a main thread");
  
  /*
   CoreLocation will call this delegate method at 1 Hz with updated range information.
   Beacons will be categorized and displayed by proximity.  A beacon can belong to multiple
   regions.  It will be displayed multiple times if that is the case.  If that is not desired,
   use a set instead of an array.
   */
  self.rangedRegions[region] = beacons;
  [self.beaconsIndexByProximity removeAllObjects];
  
  NSMutableArray *allBeacons = [NSMutableArray array];
  
  for (NSArray *regionResult in [self.rangedRegions allValues])
  {
    [allBeacons addObjectsFromArray:regionResult];
  }
  
  for (CLBeacon *locationBeacon in allBeacons)
  {
    INBeacon *beacon = [self _beaconWithUUID:locationBeacon.proximityUUID];

    if (beacon == nil)
    {
      beacon = [[INBeacon alloc] initWithCLBeacon:locationBeacon];
      [self _setBeacon:beacon forUUID:beacon.UUID];
    }
    else if (beacon.locationBeacon != locationBeacon)
    {
      beacon.locationBeacon = locationBeacon;
    }
  }
  
  for (NSNumber *range in @[@(CLProximityUnknown), @(CLProximityImmediate), @(CLProximityNear), @(CLProximityFar)])
  {
    NSArray *proximityBeacons = [allBeacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"proximity = %d", [range intValue]]];

    if([proximityBeacons count])
    {
      self.beaconsIndexByProximity[range] = proximityBeacons;
    }
  }
}

@end