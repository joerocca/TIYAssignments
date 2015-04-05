//
//  DetailSearchResultViewController.m
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DetailSearchResultViewController.h"

@import MapKit;

@interface DetailSearchResultViewController ()
{
    BOOL favorited;
}


@property (weak, nonatomic) IBOutlet UILabel *venueName;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;


- (IBAction)starTapped:(UIBarButtonItem *)sender;



@end

@implementation DetailSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"unselectedStar"] style:UIBarButtonItemStylePlain target:self action:@selector(starTapped:)];
    
    favorited = NO;
    
    
    self.venueName.text = self.venueInfo [@"name"];
//    NSString *iconPrefix = [self.venueInfo [@"categories"]objectAtIndex:0][@"icon"][@"prefix"];
//    NSString *iconSuffix = [self.venueInfo [@"categories"]objectAtIndex:0][@"icon"][@"suffix"];
//    NSString *icon = [NSString stringWithFormat:@"%@%d%@",iconPrefix,64,iconSuffix];
//    NSURL *iconURL = [NSURL URLWithString:icon];
//    NSData *imageData = [NSData dataWithContentsOfURL:iconURL];
//    UIImage *image = [UIImage imageWithData:imageData];
//    self.iconView.image = image;
//    NSLog(@"%@",icon);
    
    
    
    NSLog(@"%@",self.venueInfo);
    
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


- (IBAction)starTapped:(UIBarButtonItem *)sender
{
    
    if (favorited)
    {

        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"unselectedStar"]];
        favorited = NO;
    }
    else
    {

        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"selectedStar"]];
        favorited = YES;
    }
    
    
    

    
}








@end
