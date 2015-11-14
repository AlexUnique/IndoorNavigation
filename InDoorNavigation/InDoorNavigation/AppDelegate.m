//
//  AppDelegate.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "AppDelegate.h"
#import "INBeaconDiscoveryManager.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [[INBeaconDiscoveryManager sharedManager] startDiscovering];
  
  return YES;
}

@end
