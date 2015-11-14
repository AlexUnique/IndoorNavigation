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
#import "INBeacon.h"

@interface INCatalogueRepository ()
@property (nonatomic, strong) NSDictionary *cataloguesIndexedByUUID;
@end

@implementation INCatalogueRepository

- (NSDictionary *)cataloguesIndexedByUUID
{
  if (_cataloguesIndexedByUUID == nil)
  {
    NSArray *catalogues = [self _parseCatalogues];
    _cataloguesIndexedByUUID = [NSDictionary dictionaryWithObjects:catalogues
                                                           forKeys:[catalogues valueForKey:@"UUID"]];
  }
  
  return _cataloguesIndexedByUUID;
}

- (INCatalogue *)catalogueForBeacon:(INBeacon *)beacon
{
  return self.cataloguesIndexedByUUID[beacon.UUID];
}

- (NSArray *)_parseCatalogues
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Catalogues" ofType:@"json"];
  
  NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
  NSArray *rawCatalogues = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
  NSMutableArray *catalogues = [NSMutableArray new];
  
  for (NSDictionary *rawCatalogue in rawCatalogues)
  {
    INCatalogue *catalogue = [INCatalogue new];
    catalogue.UUID = [[NSUUID alloc] initWithUUIDString:rawCatalogue[@"id"]];
    catalogue.title = rawCatalogue[@"title"];
    catalogue.categories = [self _categoriesWithRawCategories:rawCatalogue[@"categories"]];
    [catalogues addObject:catalogue];
  }

  return catalogues;
}

- (NSArray *)_categoriesWithRawCategories:(NSArray *)rawCategories
{
  NSMutableArray *categories = [NSMutableArray new];
  
  for (NSDictionary *rawCategory in rawCategories)
  {
    INCategory *category = [INCategory new];
    category.title = rawCategory[@"title"];
    category.items = [self _productsWithRawProducts:rawCategory[@"products"]];
    [categories addObject:category];
  }
  
  return categories;
}

- (NSArray *)_productsWithRawProducts:(NSArray *)rawProducts
{
  NSMutableArray *products = [NSMutableArray new];
  
  for (NSDictionary *rawProduct in rawProducts)
  {
    INProduct *product = [INProduct new];
    product.title = rawProduct[@"title"];
    product.price = [NSDecimalNumber decimalNumberWithString:rawProduct[@"price"]];
    product.discount = [NSDecimalNumber decimalNumberWithString:rawProduct[@"discount"]];
    product.imageURL = rawProduct[@"imageURL"];
    product.highlighted = [rawProduct[@"highlighted"] boolValue];
    [products addObject:product];
  }
  
  return products;
}

@end
