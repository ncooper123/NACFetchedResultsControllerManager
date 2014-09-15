//
//  NewitemCell.m
//  LA Creel
//
//  Created by Nathan Cooper on 2013-12-17.
//  Copyright (c) 2013 LDWF. All rights reserved.
//

#import "NewItemCell.h"

@implementation NewItemCell

+ (UITableViewCell *) makeNewItemCellWithText: (NSString *) text {
  NewItemCell *cell = [[NSBundle mainBundle] loadNibNamed:@"NewItemCell" owner:self options:nil][0];
  cell.textFieldLabel.text = text;
  return cell;
}

@end
