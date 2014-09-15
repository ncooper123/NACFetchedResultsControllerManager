//
//  FetchedDataTableViewDelegate.m
//  LA Creel
//
//  Created by Nathan Cooper on 2014-09-15.
//  Copyright (c) 2014 LDWF. All rights reserved.
//

#import "FetchedDataTableViewDelegate.h"
#import "NewItemCell.h"

@implementation FetchedDataTableViewDelegate

- (void)configureCell:(UITableViewCell *)cell withObject: (NSObject *)fetchedObject atIndexPath: (NSIndexPath*)indexPath {
  return;
}

- (UITableViewCell *) getATableCell {
  return nil;
}

- (UITableViewCell *) getNewItemCell {
  return [NewItemCell makeNewItemCellWithText:[self getNewItemText]];
}

- (NSString *) getNewItemText {
  return @"New Item";
}

- (BOOL) requiresGlobalUpdate {
  return FALSE;
}

- (NSString*) getConfirmDeleteMessage {
  return @"Delete this entry?";
}

- (void) deleteObject:(NSManagedObject*)obj {
  //Don't do anything.
  return;
}


- (NSString*) getNewItemSectionName {
    return @"New Item";
}

@end
