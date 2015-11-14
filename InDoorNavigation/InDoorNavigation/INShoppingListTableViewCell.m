//
//  INShoppingListTableViewCell.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INShoppingListTableViewCell.h"
#import "INShoppingListItem.h"

@implementation INShoppingListTableViewCell

- (void)doneAction:(id)sender {
  self.onDidTapDone();
}

- (void)setItem:(INShoppingListItem *)item {
  self.titleLabel.text = item.title;
  self.doneButton.hidden = item.done;
  switch (item.status) {
    case INShoppingListItemStatusNotAvailable:
      self.titleLabel.text = @"Not Available";
      self.titleLabel.textColor = [UIColor redColor];
      break;
      
    case INShoppingListItemStatusAvailable:
      self.titleLabel.text = @"Available";
      self.titleLabel.textColor = [UIColor darkTextColor];
      break;
      
    case INShoppingListItemStatusInIsle:
      self.titleLabel.text = @"In nearest isle";
      self.titleLabel.textColor = [UIColor yellowColor];
      
      break;
      
    case INShoppingListItemStatusNear:
      self.titleLabel.text = @"Right near you";
      self.titleLabel.textColor = [UIColor greenColor];
      break;
  }
}

@end
