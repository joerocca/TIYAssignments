//
//  UserDetailViewController.m
//  25 -- Git Hub Collection
//
//  Created by Joe Rocca on 4/20/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *hireableLabel;
@property (weak, nonatomic) IBOutlet UILabel *repoLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;



@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.userInfo);
    
    self.nameLabel.text = [self.userInfo objectForKey:@"name"];
    self.emailLabel.text = [self.userInfo objectForKey:@"email"];
    self.followersLabel.text = [NSString stringWithFormat:@"%@",[self.userInfo objectForKey:@"followers"]];
    self.repoLabel.text = [NSString stringWithFormat:@"%@",[self.userInfo objectForKey:@"public_repos"]];
    NSString *hireableString = [NSString stringWithFormat:@"%@",[self.userInfo objectForKey:@"hireable"]];
    self.hireableLabel.text = [hireableString  isEqual: @"1"] ? @"Yes" : @"No";
    self.followingLabel.text = [NSString stringWithFormat:@"%@",[self.userInfo objectForKey:@"following"]];
    self.usernameLabel.text = [self.userInfo objectForKey:@"login"];
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

@end
