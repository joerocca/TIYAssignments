//
//  FriendDetailViewController.m
//  GithubFriends
//
//  Created by Joe Rocca on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "RepoCell.h"

@interface FriendDetailViewController () <UITableViewDelegate, UITableViewDataSource, NSURLSessionDataDelegate>
{
    NSArray *repos;
    UILabel *location;
    UILabel *email;
    UITableView *repositories;
    NSMutableData *receivedData;
}

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.friendInfo [@"login"];
    


    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    
    NSString *userLogin = [self.friendInfo objectForKey:@"login"];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos",userLogin];
    
    NSURL *url = [NSURL URLWithString:urlString];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    repos = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//    
//    NSLog(@"%@",repos);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
    
    
    
    location = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 40)];
    location.textAlignment = NSTextAlignmentCenter;
    location.backgroundColor = [UIColor darkGrayColor];
    location.textColor = [UIColor whiteColor];
    
    [self.view addSubview:location];
    
   
    
    CGFloat emailY = location.frame.origin.y + location.frame.size.height + 10;
    email = [[UILabel alloc] initWithFrame:CGRectMake(10, emailY, 300, 40)];
    email.textAlignment = NSTextAlignmentCenter;
    email.backgroundColor = [UIColor darkGrayColor];
    email.textColor = [UIColor whiteColor];

    [self.view addSubview:email];
    
    CGFloat reposY = email.frame.origin.y + email.frame.size.height + 10;
    CGFloat reposWidth = self.view.frame.size.width;
    CGFloat reposHeight = self.view.frame.size.height - reposY;
    repositories = [[UITableView alloc] initWithFrame:CGRectMake(0, reposY, reposWidth, reposHeight)];
    repositories.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:repositories];
    
   
    [repositories registerClass:[RepoCell class] forCellReuseIdentifier:@"RepoCell"]; //has to be below init or it wont contain anything

    
    
    location.text = [self.friendInfo objectForKey:@"location"];
    email.text = [self.friendInfo objectForKey:@"email"];
    
    
     repositories.delegate = self;
    repositories.dataSource = self;
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
    
    
    
    
    
    cell.textLabel.text = repos[indexPath.row][@"name"];
   
    
    if (repos[indexPath.row][@"description"] != [NSNull null])
    {
        cell.detailTextLabel.text = repos[indexPath.row][@"description"];
    }
    
    
    
    return cell;
}


#pragma mark -- NSURLSessionData delegate

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if(!receivedData)
    {
        receivedData =[[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData appendData:data];
    }
    
    
}

- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if(!error)
    {
        NSLog(@"Download Successful");
        repos = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        [repositories reloadData];
       
    }
    
}










@end
