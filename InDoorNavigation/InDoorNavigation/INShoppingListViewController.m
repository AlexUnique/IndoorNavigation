//
//  INShoppingListViewController.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INShoppingListViewController.h"

@interface INShoppingListViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextField *textField;

- (IBAction)addAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end

@implementation INShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;
}

- (void)cancelAction:(id)sender {
    [self.view endEditing:YES];
}

- (void)addAction:(id)sender {
    
}

@end
