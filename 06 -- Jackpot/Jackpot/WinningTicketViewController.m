//
//  WinningTicketViewController.m
//  Jackpot
//
//  Created by Joe Rocca on 3/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "WinningTicketViewController.h"

@interface WinningTicketViewController () 

@property (weak, nonatomic) IBOutlet UITextField *fieldOne;
@property (weak, nonatomic) IBOutlet UITextField *fieldTwo;
@property (weak, nonatomic) IBOutlet UITextField *fieldThree;
@property (weak, nonatomic) IBOutlet UITextField *fieldFour;
@property (weak, nonatomic) IBOutlet UITextField *fieldFive;
@property (weak, nonatomic) IBOutlet UITextField *fieldSix;



- (IBAction)checkTicketButton:(UIButton *)sender;


@end

@implementation WinningTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Enter Winning Numbers";
    
    
    // Do any additional setup after loading the view.
}


- (void)viewWillDisappear:(BOOL)animated
   {
       [super viewDidDisappear:animated];
       

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

- (IBAction)checkTicketButton:(UIButton *)sender
{
    NSArray *fieldArray = @[self.fieldOne.text, self.fieldTwo.text, self.fieldThree.text, self.fieldFour.text, self.fieldFive.text, self.fieldSix.text];
    
    NSLog(@"%@", fieldArray);
    
    [self.delegate winningTicketNumberWasChosen:fieldArray];
    
    [self.navigationController popToRootViewControllerAnimated:YES];  //however many views are stacked upon the last, go back to the initial view
}
@end


