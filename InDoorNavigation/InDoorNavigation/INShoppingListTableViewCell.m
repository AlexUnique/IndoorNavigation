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
      self.statusLabel.text = @"Not Available";
      self.statusLabel.textColor = [UIColor redColor];
      break;
      
    case INShoppingListItemStatusAvailable:
      self.statusLabel.text = @"Available";
      self.statusLabel.textColor = [UIColor darkTextColor];
      break;
      
    case INShoppingListItemStatusInIsle:
      self.statusLabel.text = @"In nearest isle";
      self.statusLabel.textColor = [UIColor blueColor];
      
      break;
      
    case INShoppingListItemStatusNear:
      self.statusLabel.text = @"Right near you";
      self.statusLabel.textColor = [UIColor greenColor];
      break;
  }
}

@end
