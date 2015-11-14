//
//  INShoppingListControllerDataSource.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INShoppingListItem.h"

@class INBeacon;

@protocol INShoppingListControllerDataSource <NSObject>

- (INShoppingListItemStatus)statusForItemWithTitle:(NSString *)title nearBeacon:(INBeacon *)beacon;

@end
