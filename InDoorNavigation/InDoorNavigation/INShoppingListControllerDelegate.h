//
//  INShoppingListControllerDelegate.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INShoppingListItem;

@protocol INShoppingListControllerDelegate <NSObject>

- (void)showItems:(NSArray<INShoppingListItem *> *)items;

@end
