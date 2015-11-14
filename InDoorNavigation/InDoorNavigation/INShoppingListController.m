//
//  INShoppingListController.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INShoppingListController.h"
#import "INShoppingListItem.h"
#import "INBeacon.h"

@interface INShoppingListController ()

@property (nonatomic, strong) INBeacon *currentBeacon;
@property (nonatomic, strong) NSMutableArray<INShoppingListItem *> *items;

- (void)updateItemsStatus;

@end

@implementation INShoppingListController

- (void)addItemWithTitle:(NSString *)title {
    INShoppingListItem *item = [INShoppingListItem new];
    item.title = title;
    
    [self.items addObject:item];
    [self updateItemsStatus];
}

- (void)completeItem:(INShoppingListItem *)item {
    item.done = YES;
    
    [self updateItemsStatus];
}

- (void)updateItemsStatus {
    for (INShoppingListItem *item in self.items) {
        item.status = [self.dataSource statusForItemWithTitle:item.title nearBeacon:self.currentBeacon];
    }
    
    NSSortDescriptor *doneSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"done" ascending:YES];
    NSSortDescriptor *statusSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"status" ascending:NO];
    NSSortDescriptor *titleSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    
    [self.items sortUsingDescriptors:@[doneSortDescriptor, statusSortDescriptor, titleSortDescriptor]];
    
    [self.delegate showItems:self.items];
}

- (void)discoverBeacon:(INBeacon *)beacon {
    if (![self.currentBeacon isEqual:beacon])
    {
        self.currentBeacon = beacon;
        [self updateItemsStatus];
    }
}

@end
