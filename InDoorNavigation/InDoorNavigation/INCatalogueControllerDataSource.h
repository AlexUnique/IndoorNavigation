//
//  INCatalogueControllerDataSource.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INCatalogue;
@class INBeacon;

@protocol INCatalogueControllerDataSource <NSObject>

- (INCatalogue *)catalogueForBeacon:(INBeacon *)beacon;

@end
