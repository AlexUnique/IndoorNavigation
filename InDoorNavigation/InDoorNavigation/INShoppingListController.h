//
//  INShoppingListController.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INShoppingListControllerDelegate.h"
#import "INShoppingListControllerDataSource.h"

@class INShoppingListItem;
@class INBeacon;

@interface INShoppingListController : NSObject

@property (nonatomic, weak) id<INShoppingListControllerDelegate> delegate;
@property (nonatomic, weak) id<INShoppingListControllerDataSource> dataSource;

- (void)addItemWithTitle:(NSString *)title;
- (void)completeItem:(INShoppingListItem *)item;

- (void)discoverBeacon:(INBeacon *)beacon;

@end
