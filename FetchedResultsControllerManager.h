//
//  FetchedResultsControllerManager.h
//
//  Created by Nathan Cooper on 10/8/13.

/**
 * This class abstracts some details from the UIViewControllers fetching data from a
 * FetchedResultsController. Initiate and set its delegate to the corresponding
 * class and it will automatically perform table updates, etc.
 */

#import <Foundation/Foundation.h>
#import "FetchedDataTableViewDelegate.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FetchedResultsControllerManager : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

/** Creates and initializes the instance.*/
- (id) initWithTableView:(UITableView *)tableView withDelegate:(FetchedDataTableViewDelegate *) delegate withFetchedResultsController:(NSFetchedResultsController *)controller allowEditing:(BOOL)allowEditing allowAdding:(BOOL)allowAdding;

/** Activates/deactivates the FetchedResultsControllerManager.*/
- (void) start;
- (void) stop;

/** Returns the object associated with an index path, or nil for the New Item position.*/
- (NSObject *) getObjectAtIndexPath:(NSIndexPath*) indexPath;

@end
