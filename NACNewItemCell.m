//
//  NewitemCell.m
//  LA Creel
//
//  Created by Nathan Cooper on 2013-12-17.
//  Copyright (c) 2013 LDWF. All rights reserved.
//

#import "NACNewItemCell.h"

@implementation NACNewItemCell

+ (UITableViewCell *) makeNewItemCellWithText: (NSString *) text {
  NewItemCell *cell = [[NSBundle mainBundle] loadNibNamed:@"NewItemCell" owner:self options:nil][0];
  [cell.imageViewIcon setImage: [UIImage imageNamed:@"new-icon.png"]];
  cell.textFieldLabel.text = text;
  return cell;
}

@end
