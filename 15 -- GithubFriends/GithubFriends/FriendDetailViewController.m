//
//  FriendDetailViewController.m
//  GithubFriends
//
//  Created by Joe Rocca on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "RepoCell.h"

@interface FriendDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *repos;
    UILabel *location;
    UILabel *email;
    UITableView *repositories;
}

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    repos = [[NSArray alloc] init];
    
    [repositories registerClass:[RepoCell class] forCellReuseIdentifier:@"RepoCell"];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    
    NSString *userLogin = [self.friendInfo objectForKey:@"login"];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos",userLogin];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    repos = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@",repos);
    
    
    
    location = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 40)];
    location.textAlignment = NSTextAlignmentCenter;
    location.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:location];
    
   
    
    CGFloat emailY = location.frame.origin.y + location.frame.size.height + 10;
    email = [[UILabel alloc] initWithFrame:CGRectMake(10, emailY, 300, 40)];
    email.textAlignment = NSTextAlignmentCenter;
    email.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:email];
    
    CGFloat reposY = email.frame.origin.y + email.frame.size.height + 10;
    CGFloat reposWidth = self.view.frame.size.width;
    CGFloat reposHeight = self.view.frame.size.height - reposY;
    repositories = [[UITableView alloc] initWithFrame:CGRectMake(0, reposY, reposWidth, reposHeight)];
    repositories.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:repositories];

    
    
    location.text = [self.friendInfo objectForKey:@"location"];
    email.text = [self.friendInfo objectForKey:@"email"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -- Table View




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [repos count]; //match up item in out array to the cells in out table view
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoCell" forIndexPath:indexPath]; //because we are using a custom cell class we call it specifically
    
    
    
    
    NSDictionary *repo =  repos[indexPath.row];
    
    cell.textLabel.text = [repo objectForKey:@"name"];
    
    
    
    return cell;
}





@end
