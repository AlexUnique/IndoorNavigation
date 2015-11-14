//
//  INCatalogue.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INCategory;

@interface INCatalogue : NSObject

@property (nonatomic, copy) NSArray<INCategory *> *categories;

@end
