//
//  INCatalogueController.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INCatalogueControllerDelegate.h"
#import "INCatalogueControllerDataSource.h"

@class INBeacon;

@interface INCatalogueController : NSObject

@property (nonatomic, weak) id<INCatalogueControllerDelegate> delegate;
@property (nonatomic, weak) id<INCatalogueControllerDataSource> dataSource;

- (void)discoverBeacon:(INBeacon *)beacon;

@end
