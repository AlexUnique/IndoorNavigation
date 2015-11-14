//
//  INCatalogueViewController.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INCatalogueViewController.h"
#import "INCatalogueTableViewCell.h"
#import "INProduct.h"
#import "INCategory.h"
#import "INCatalogue.h"

#import "INCatalogueController.h"
#import "INCatalogueRepository.h"

@interface INCatalogueViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray<INCategory *> *categories;

@property (nonatomic, strong) INCatalogueController *catalogueController;
@property (nonatomic, strong) INCatalogueRepository *repository;

- (INCategory *)categoryAtIndex:(NSInteger)index;
- (INProduct *)productAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation INCatalogueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40.0;
    
    self.repository = [INCatalogueRepository new];
    self.catalogueController = [INCatalogueController new];
    self.catalogueController.delegate = self;
    self.catalogueController.dataSource = self.repository;
    [self.catalogueController discoverBeacon:nil];
}

- (void)setCatalogue:(INCatalogue *)catalogue {
    self.categories = catalogue.categories;
    [self.tableView reloadData];
}

- (INCategory *)categoryAtIndex:(NSInteger)index {
    return self.categories[index];
}

- (INProduct *)productAtIndexPath:(NSIndexPath *)indexPath {
    return [self categoryAtIndex:indexPath.section].items[indexPath.row];
}

#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self categoryAtIndex:section].items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    INCatalogueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([INCatalogueTableViewCell class])
                                                                     forIndexPath:indexPath];
    
    [cell setProduct:[self productAtIndexPath:indexPath]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self categoryAtIndex:section].title;
}

@end
