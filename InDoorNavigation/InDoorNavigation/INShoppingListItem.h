//
//  INShoppingListItem.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, INShoppingListItemStatus) {
    INShoppingListItemStatusNotAvailable = 0,
    INShoppingListItemStatusAvailable,
    INShoppingListItemStatusInIsle,
    INShoppingListItemStatusNear
};

@interface INShoppingListItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL done;
@property (nonatomic, assign) INShoppingListItemStatus status;

@end
