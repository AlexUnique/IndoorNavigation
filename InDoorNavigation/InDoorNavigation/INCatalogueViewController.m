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

@interface INCatalogueViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray<INCategory *> *categories;

- (INCategory *)categoryAtIndex:(NSInteger)index;
- (INProduct *)productAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation INCatalogueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
