//
//  FetchedResultsControllerManager.m
//  Created by Nathan Cooper on 10/8/13.
//

#import "FetchedResultsControllerManager.h"
#import "UIAlertView+MKBlockAdditions.h"

@interface FetchedResultsControllerManager ()

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSFetchedResultsController* fetchedResultsController;
@property (strong, nonatomic) FetchedDataTableViewDelegate *delegate;
@property BOOL allowEditing, allowAdding;

@end

@implementation FetchedResultsControllerManager

@synthesize tableView = _tableView;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize delegate = _delegate;
@synthesize allowEditing = _allowEditing;
@synthesize allowAdding = _allowAdding;

/**
 * Initializes a FetchedResultsControllerManager with a given UITableView, delegate, and NSFetchedResultsController.
 */
-(id) initWithTableView:(UITableView *)tableView withDelegate:(FetchedDataTableViewDelegate *) delegate withFetchedResultsController:(NSFetchedResultsController *)controller allowEditing:(BOOL)allowEditing allowAdding:(BOOL)allowAdding {
    self = [super init];
    if (self){
      self.tableView = tableView;
      self.allowEditing = allowEditing;
      self.allowAdding = allowAdding;
      self.delegate = delegate;
      self.fetchedResultsController = controller;
    }
    return self;
}

/**
 * Sets up and activates this instance by setting the corresponding delegates and performing the fetch.
 */
-(void) start {
    self.tableView.dataSource = self;
    self.fetchedResultsController.delegate = self;
    NSError *error;
    if ([self.fetchedResultsController performFetch:&error]) {
      [self.tableView reloadData];
    }
}

/**
 * Detaches this FetchedResultsControllerManager from the table/delegate.
 */
-(void) stop {
    self.tableView.dataSource = nil;
    self.fetchedResultsController.delegate = nil;
    [self.tableView reloadData];
    //self.fetchedResultsController = nil;
    //self.delegate = nil;
    //self.tableView = nil;
}

-(NSObject *) getObjectAtIndexPath:(NSIndexPath*)indexPath {
  if ([[self.fetchedResultsController sections] count] == indexPath.section){
    return nil;
  }
  return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

#pragma UITableViewDataSource

/**
 * We can never "delete" the "new item" record, but we may be able to delete the others.
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  BOOL canEdit = (indexPath.section == [[self.fetchedResultsController sections] count]) ? FALSE : self.allowEditing;
  return canEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  NSManagedObject *obj = [self.fetchedResultsController objectAtIndexPath:indexPath];
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    BOOL deleteable = [self.delegate canDeleteObjectAtIndexPath:indexPath withObject:obj];
    if (!deleteable){
        //Not deletable.
        NSString *message = [self.delegate getUnableToDeleteMessageAtIndexPath:indexPath withObject:obj];
        [UIAlertView alertViewWithTitle:@"Message" message:message cancelButtonTitle:@"OK" otherButtonTitles:@[] onDismiss:^(int buttonIndex) {
            //Not applicable.
        } onCancel:^{
            [self.tableView setEditing:NO animated:YES];
        }];
    }
    else {
        //Option to delete.
        NSString *message = [self.delegate getConfirmDeleteMessageAtIndexPath:indexPath withObject:obj];
        if (message != nil){
            [UIAlertView alertViewWithTitle:@"Delete?" message:message cancelButtonTitle:@"No" otherButtonTitles:@[@"Yes"] onDismiss:^(int buttonIndex) {
                [self.delegate deleteObject:obj];
            } onCancel:^{
                [self.tableView setEditing:NO animated:YES];
            }];
        }
        else {
            [self.delegate deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        }
    }
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == [[self.fetchedResultsController sections] count]){
    return [self.delegate getNewItemSectionName];
  }
  else{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
  }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  NSUInteger count = [[self.fetchedResultsController sections] count];
  if (self.allowAdding == TRUE)
    return count + 1;
  else
    return count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == [[self.fetchedResultsController sections] count]){
      return 1;
    }
    else{
      id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
      return [sectionInfo numberOfObjects];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == [[self.fetchedResultsController sections] count]){
    return [self.delegate getNewItemCell];
  }
  else{
    UITableViewCell* cell = [self.delegate getATableCell];
    [self.delegate configureCell:cell withObject:[self.fetchedResultsController objectAtIndexPath:indexPath] atIndexPath:indexPath];
    return cell;
  }
}

#pragma NSFetchedResultsControllerDelegate

/**
 * The below is mostly copy-and-pasted from Apple sources and various tutorial websites, modified to make
 * use of this somewhat-hacked-together pattern I've created.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        break;
            
        case NSFetchedResultsChangeUpdate:
            [self.delegate configureCell:[self.tableView cellForRowAtIndexPath:indexPath] withObject:[self.fetchedResultsController objectAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    if (type == NSFetchedResultsChangeDelete && [self.delegate requiresGlobalUpdate]){
      /**
       * The delegate has marked requiredGlobalUpdate as true. This is used when
       * deleting one item requires a refresh of the data. This is used in the AssignmentViewController,
       * where each row has a visible index. Deleting one row requires all numbers after to be updated.
       */
      dispatch_async(dispatch_get_main_queue(),^{
        [self.tableView reloadData];
      });
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


@end
