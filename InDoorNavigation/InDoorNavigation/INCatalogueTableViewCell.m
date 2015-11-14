//
//  INCatalogueTableViewCell.m
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import "INCatalogueTableViewCell.h"
#import "INProduct.h"

@implementation INCatalogueTableViewCell

- (void)setProduct:(INProduct *)product {
    self.titleLabel.text = product.title;
    self.priceLabel.text = product.price.stringValue;
    self.discountLabel.text = product.discount.stringValue;
}

@end
