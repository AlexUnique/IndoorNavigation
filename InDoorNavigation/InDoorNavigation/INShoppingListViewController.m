//
//  INShoppingListViewController.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INShoppingListViewController.h"
#import "INShoppingListTableViewCell.h"
#import "INBeaconDiscoveryManager.h"
#import "INShoppingListController.h"

@interface INShoppingListViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextField *textField;

@property (nonatomic, copy) NSArray<INShoppingListItem *> *items;
@property (nonatomic, strong) INShoppingListController *shoppingListController;

- (IBAction)addAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end

@implementation INShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;
    
    self.shoppingListController = [INShoppingListController new];
    self.shoppingListController.delegate = self;
}

- (void)cancelAction:(id)sender {
    [self.view endEditing:YES];
}

- (void)addAction:(id)sender {
    [self.shoppingListController addItemWithTitle:self.textField.text];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self _subscribeForBeaconDiscoveryManagerNotifications];
    [self _beaconDiscoveryManagerDidUpdateBeacons];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self _unsubscribeFromBeaconDiscoveryManagerNotifications];
}

#pragma mark - INShoppingListControllerDelegate

- (void)showItems:(NSArray<INShoppingListItem *> *)items {
    self.items = items;
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    INShoppingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([INShoppingListTableViewCell class])
                                                                        forIndexPath:indexPath];
    
    [cell setItem:self.items[indexPath.row]];
    
    return cell;
}

#pragma mark - INBeaconDiscoveryManager Notifications

- (void)_subscribeForBeaconDiscoveryManagerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_beaconDiscoveryManagerDidUpdateBeacons)
                                                 name:INBeaconDiscoveryManagerDidUpdateDiscoveredBeacons
                                               object:nil];
}

- (void)_unsubscribeFromBeaconDiscoveryManagerNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:INBeaconDiscoveryManagerDidUpdateDiscoveredBeacons object:nil];
}

- (void)_beaconDiscoveryManagerDidUpdateBeacons
{
    INBeacon *nearestBeacon = [INBeaconDiscoveryManager sharedManager].nearestBeacon;
    
    [self.shoppingListController discoverBeacon:nearestBeacon];
}

@end
