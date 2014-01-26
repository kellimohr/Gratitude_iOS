//
//  GDetailViewController.m
//  Gratitude
//
//  Created by Kelli Mohr on 1/16/14.
//  Copyright (c) 2014 Kelli Mohr. All rights reserved.
//

#import "GDetailViewController.h"

@interface GDetailViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *postDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
- (void)configureView;
@end

@implementation GDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.categoryTextField.text = [self.detailItem valueForKey:@"category"];
        self.postDescriptionTextView.text = [self.detailItem valueForKey:@"post_description"];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self.categoryTextField becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.categoryTextField]) {
        [self.detailItem setValue:textField.text forKey:@"category"];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView isEqual:self.postDescriptionTextView]) {
        [self.detailItem setValue:textView.text forKey:@"post_description"];
    }
}

#pragma mark - Private methods

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self.detailItem managedObjectContext];
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
