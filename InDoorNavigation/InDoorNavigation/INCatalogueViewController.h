//
//  INCatalogueViewController.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class INCatalogue;

@interface INCatalogueViewController : UIViewController <UITableViewDataSource>

- (void)setCatalogue:(INCatalogue *)catalogue;

@end
