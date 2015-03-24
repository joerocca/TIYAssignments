//
//  NewFriendViewController.m
//  GithubFriends
//
//  Created by Joe Rocca on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "NewFriendViewController.h"

@interface NewFriendViewController () <NSURLSessionDataDelegate>
{
    UITextField *usernameTextField;
    NSMutableData *receivedData;
}
@end

@implementation NewFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, 300, 40)];
    usernameTextField.placeholder = @"Username";
    usernameTextField.textAlignment = NSTextAlignmentCenter;
    usernameTextField.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:usernameTextField];
    
    CGFloat saveFriendY = usernameTextField.frame.origin.y + usernameTextField.frame.size.height + 10;
    UIButton *saveFriend = [[UIButton alloc] initWithFrame:CGRectMake(10, saveFriendY, 300, 40)];
    [saveFriend setTitle:@"Git User" forState:UIControlStateNormal];
    [saveFriend addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveFriend];
    
    CGFloat cancelY = saveFriend.frame.origin.y + saveFriend.frame.size.height + 10;
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, cancelY, 300, 40)];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:cancelButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)save
{
    NSString *username = usernameTextField.text;
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@",username];
    NSURL *url = [NSURL URLWithString:urlString];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    //    [self.friends addObject:userInfo];
    

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url]; //starts in paused state; have to tell it to resume.
    
    [dataTask resume];
    
//    [self cancel];
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -- NSURlSession delegate

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if(!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    
    else
    {
        [receivedData appendData:data];
    }
}

- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error //if didnt complete, this will point to error
{
    if (!error)
    {
        NSLog(@"Download Successful.");
        NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        [self.friends addObject:userInfo];
        [self cancel];
        
        NSLog(@"%@",self.friends);
    }
}




@end
