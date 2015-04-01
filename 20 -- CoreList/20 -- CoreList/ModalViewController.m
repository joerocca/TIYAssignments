//
//  ModalViewController.m
//  20 -- CoreList
//
//  Created by Joe Rocca on 3/31/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ModalViewController.h"
#import "ListItem.h"

@interface ModalViewController ()<UITextFieldDelegate>


- (IBAction)saveButton:(UIButton *)sender;

- (IBAction)cancelButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *itemTextField;


@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Action Handlers


- (IBAction)saveButton:(UIButton *)sender
{
    
    if (![self.itemTextField.text isEqualToString:@""])
    {
        
    ListItem *anItem = [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:self.cdStack.managedObjectContext];
        
    anItem.item = self.itemTextField.text;
    
    [self saveCoreDataUpdates];
    
    [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}


- (IBAction)cancelButton:(UIButton *)sender
{
    [self.itemTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Methods

- (void)saveCoreDataUpdates
{
    [self.cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack: %@",[errorOrNil localizedDescription]);
         }
     }];
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
 
    [textField resignFirstResponder];
        
        
    
    
    return YES;
}

@end
