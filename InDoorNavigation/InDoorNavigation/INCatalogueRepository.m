//
//  INCatalogueRepository.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INCatalogueRepository.h"
#import "INCatalogue.h"
#import "INCategory.h"
#import "INProduct.h"

@implementation INCatalogueRepository

- (INCatalogue *)catalogueForBeacon:(INBeacon *)beacon {
    return [self catalogue0];
}

- (INCatalogue *)catalogue0 {
    INCatalogue *catalogue = [INCatalogue new];
    NSArray *cats = @[@[@"Sweets", @[@[@"Hersheys", @"5.00", @""],
                        @[@"Snikers", @"6.00", @""],
                        @[@"Mars", @"7.00", @""],
                        @[@"Bounty", @"8.00", @""]]],
                      @[@"Cheese", @[@[@"Old", @"4.00", @"-2.00"],
                        @[@"Mild", @"6.00", @"-5.00"],
                        @[@"Mozzarella", @"3.00", @"-2.00"],
                        @[@"Medium", @"6.00", @""],
                        @[@"Garlic", @"5.00", @"-4.00"],
                        @[@"Part Skim", @"9.00", @"-2.00"],
                        @[@"Marble", @"1.00", @""]]],
                      @[@"Bread", @[@[@"Garlic", @"7.00", @""],
                        @[@"White", @"6.00", @""],
                        @[@"Rye", @"5.00", @""],
                        @[@"Baguette", @"8.00", @"-2.50"],
                        @[@"Ciabatta", @"6.00", @"-2.00"]]]];
    
    NSMutableArray *catsMade = [NSMutableArray new];
    for (NSArray *arr in cats) {
        [catsMade addObject:[self categoryFromArray:arr]];
    }
    for (INProduct *product in [catsMade[0] items]) {
        product.highlighted = YES;
    }
    catalogue.categories = catsMade;
    
    return catalogue;
}

- (INCategory *)categoryFromArray:(NSArray *)array {
    INCategory *category = [INCategory new];
    
    category.title = array[0];
    NSMutableArray *products = [NSMutableArray new];
    for (NSArray *arr in array[1]) {
        [products addObject:[self productWithTitle:arr[0] price:arr[1] dscount:arr[2]]];
    }
    category.items = products;
    
    return category;
}

- (INProduct *)productWithTitle:(NSString *)title price:(NSString *)priceString dscount:(NSString *)discountString {
    INProduct *product = [INProduct new];
    
    product.title = title;
    product.price = [NSDecimalNumber decimalNumberWithString:priceString];
    product.discount = [NSDecimalNumber decimalNumberWithString:discountString];
    
    return product;
}

@end
