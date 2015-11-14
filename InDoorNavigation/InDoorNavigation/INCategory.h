//
//  INCategory.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INProduct;

@interface INCategory : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<INProduct *> *items;

@end
