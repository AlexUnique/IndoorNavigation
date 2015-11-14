//
//  INCatalogueTableViewCell.h
//  InDoorNavigation
//
//  Created by Roman Temchenko on 2015-11-14.
//  Copyright © 2015 Temkal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class INProduct;

@interface INCatalogueTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *productImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UILabel *discountLabel;
@property (nonatomic, strong) IBOutlet UIView *highlightingIndicator;

- (void)setProduct:(INProduct *)product;

@end
