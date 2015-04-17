//
//  FetchedDataTableViewDelegate.m
//  LA Creel
//
//  Created by Nathan Cooper on 2014-09-15.
//  Copyright (c) 2014 LDWF. All rights reserved.
//

#import "NACFetchedDataTableViewDelegate.h"
#import "NACNewItemCell.h"

@implementation NACFetchedDataTableViewDelegate

- (void)configureCell:(UITableViewCell *)cell withObject: (NSObject *)fetchedObject atIndexPath: (NSIndexPath*)indexPath {
  return;
}

- (UITableViewCell *) getATableCell {
  return nil;
}

- (UITableViewCell *) getNewItemCell {
  return [NACNewItemCell makeNewItemCellWithText:[self getNewItemText]];
}

- (NSString *) getNewItemText {
  return @"New Item";
}

- (BOOL) requiresGlobalUpdate {
  return FALSE;
}

- (NSString*) getConfirmDeleteMessageAtIndexPath:(NSIndexPath*)path withObject:(NSManagedObject*)obj {
  return @"Delete this entry?";
}

- (NSString*) getUnableToDeleteMessageAtIndexPath:(NSIndexPath*)path withObject:(NSManagedObject *)obj {
    return @"You cannnot delete this entry.";
}

- (BOOL) canDeleteObjectAtIndexPath:(NSIndexPath*)path withObject:(NSManagedObject *)obj {
    return TRUE;
}

- (void) deleteObject:(NSManagedObject*)obj {
  //Don't do anything.
  return;
}


- (NSString*) getNewItemSectionName {
    return @"New Item";
}

- (void) performConfirmationWithTitle:(NSString*)title withText:(NSString*) text withConfirmation:(void(^)()) confirmation withCancellation:(void(^)()) cancellation {
    NSLog(@"Skipping confirmation: %@",title);
    confirmation();
    
}

- (void) displayMessageWithTitle:(NSString*)title withText:(NSString*)text{
    NSLog(@"Skipping message: %@", title);
}

@end
