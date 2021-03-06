//
//  INCatalogueRepository.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INCatalogueControllerDataSource.h"
#import "INShoppingListControllerDataSource.h"

@interface INCatalogueRepository : NSObject <INCatalogueControllerDataSource, INShoppingListControllerDataSource>

@end
