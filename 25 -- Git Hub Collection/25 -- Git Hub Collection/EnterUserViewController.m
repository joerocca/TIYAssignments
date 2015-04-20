//
//  ViewController.m
//  25 -- Git Hub Collection
//
//  Created by Joe Rocca on 4/20/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "EnterUserViewController.h"

@interface EnterUserViewController ()<NSURLSessionDataDelegate>
{
     NSMutableData *receivedData;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

- (IBAction)submitButton:(UIButton *)sender;

- (IBAction)cancelButton:(UIButton *)sender;

@end

@implementation EnterUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.users = [[NSMutableArray alloc] init];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)save
{
    NSString *username = self.usernameTextField.text;
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
        [self.users addObject:userInfo];
        [self cancel];
        
        NSLog(@"%@",self.users);
    }
}

#pragma mark - Action Handlers


- (IBAction)submitButton:(UIButton *)sender
{
    [self save];
}

- (IBAction)cancelButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
