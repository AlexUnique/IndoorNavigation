//
//  INShoppingListTableViewCell.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class INShoppingListItem;

@interface INShoppingListTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;

@property (nonatomic, copy) void (^onDidTapDone)();

- (IBAction)doneAction:(id)sender;

- (void)setItem:(INShoppingListItem *)item;

@end
