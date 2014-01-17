//
//  GMasterViewController.h
//  Gratitude
//
//  Created by Kelli Mohr on 1/16/14.
//  Copyright (c) 2014 Kelli Mohr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface GMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
