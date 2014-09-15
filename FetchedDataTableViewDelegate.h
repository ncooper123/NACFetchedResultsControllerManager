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
- (NSString*) getConfirmDeleteMessage;

/**Action to perform when deleting an object.*/
- (void) deleteObject:(NSManagedObject*)obj;

/**Section name for the new item table.*/
- (NSString*) getNewItemSectionName;

@end
