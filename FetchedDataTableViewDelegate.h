//
//  NSFetchedTableView.h
//  Created by Nathan Cooper on 10/8/13.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FetchedDataTableViewDelegate : UIViewController

@property (strong, nonatomic) UITableView *tableView;

/** How to configure a given cell with the object. The corresponding NSIndexPath is given as a convenience.*/
- (void)configureCell:(UITableViewCell *)cell withObject: (NSObject *)fetchedObject atIndexPath: (NSIndexPath*)indexPath;

/** How to retrieve a cell.*/
- (UITableViewCell *) getATableCell;

/**How to get a cell corresponding to a new item.*/
- (UITableViewCell *) getNewItemCell;

/**Default text for the NewItemCell, if getNewItemCell is not being overwritten.*/
- (NSString *) getNewItemText;

/**Whether or not all cells have to updated when a cell is deleted/added.*/
- (BOOL) requiresGlobalUpdate;

/**Confirm deletion.*/
- (NSString*) getConfirmDeleteMessageAtIndexPath:(NSIndexPath*)path withObject:(NSManagedObject*)obj;

/**Explain why you cannot delete it.*/
- (NSString*) getUnableToDeleteMessageAtIndexPath:(NSIndexPath*)path withObject:(NSManagedObject*)obj;

/**Whether you can delete thi object (if deletions are turned on, that is).*/
- (BOOL) canDeleteObjectAtIndexPath:(NSIndexPath*)path withObject:(NSManagedObject *)obj;

/**Action to perform when deleting an object.*/
- (void) deleteObject:(NSManagedObject*)obj;

/**Section name for the new item table.*/
- (NSString*) getNewItemSectionName;

/**Perform a confirmation with callbacks.*/
- (void) performConfirmationWithTitle:(NSString*)title withText:(NSString*) text withConfirmation:(void(^)()) confirmation withCancellation:(void(^)()) cancellation;

/**Perform a message.*/
- (void) displayMessageWithTitle:(NSString*)title withText:(NSString*)text;

@end
