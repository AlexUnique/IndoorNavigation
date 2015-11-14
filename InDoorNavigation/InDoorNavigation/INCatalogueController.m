//
//  INCatalogueController.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INCatalogueController.h"

@implementation INCatalogueController

- (void)discoverBeacon:(INBeacon *)beacon {
    INCatalogue *catalogue = [self.dataSource catalogueForBeacon:beacon];
    [self.delegate setCatalogue:catalogue];
}

@end
