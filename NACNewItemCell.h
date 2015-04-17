//
//  NewItemCell.h
//  LA Creel
//
//  Created by Nathan Cooper on 2013-12-17.
//  Copyright (c) 2013 LDWF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NACNewItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *textFieldLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewIcon;

+ (UITableViewCell *) makeNewItemCellWithText: (NSString *) text;

@end
