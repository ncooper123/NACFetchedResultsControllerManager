//
//  FetchedResultsControllerManager.h
//  LA Creel
//
//  Created by Nathan Cooper on 10/8/13.
//  Copyright (c) 2013 LDWF. All rights reserved.
//

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

-(id) initWithTableView:(UITableView *)tableView withDelegate:(id<FetchedDataTableViewDelegate>) delegate withFetchedResultsController:(NSFetchedResultsController *)controller allowEditing:(BOOL)allowEditing allowAdding:(BOOL)allowAdding;
-(void) start;
-(NSObject *) getObjectAtIndexPath:(NSIndexPath*)indexPath;
-(void) stop;

@end
