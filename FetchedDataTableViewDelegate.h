//
//  NSFetchedTableView.h
//  LA Creel
//
//  Created by Nathan Cooper on 10/8/13.
//  Copyright (c) 2013 LDWF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol FetchedDataTableViewDelegate

/** How to configure a given cell with the object. The corresponding NSIndexPath is given as a convenience.*/
- (void)configureCell:(UITableViewCell *)cell withObject: (NSObject *)fetchedObject atIndexPath: (NSIndexPath*)indexPath;

/** How to retrieve a cell.*/
- (UITableViewCell *) getATableCell;

/**Whether or not all cells have to updated when a cell is deleted/added.*/
- (BOOL) requiresGlobalUpdate;

@optional
- (NSString*) getConfirmDeleteMessage;

@optional
- (void) deleteObject:(NSManagedObject*)obj;

@optional
- (NSString*) getNewItemText;

@optional
- (NSString*) getNewItemSectionName;

@end
