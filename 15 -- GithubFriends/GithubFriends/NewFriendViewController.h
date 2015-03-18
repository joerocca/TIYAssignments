//
//  NewFriendViewController.h
//  GithubFriends
//
//  Created by Joe Rocca on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFriendViewController : UIViewController




@property (nonatomic) NSMutableArray *friends;  //nonatomic means it can be updated by many people //strong/weak decalres how strongly it hangs on to the pointer //if you leave out weak/strong it automatically declares the property as strong





@end
