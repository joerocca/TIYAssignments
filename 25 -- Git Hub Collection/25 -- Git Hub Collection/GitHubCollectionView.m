//
//  GitHubCollectionView.m
//  25 -- Git Hub Collection
//
//  Created by Joe Rocca on 4/20/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "GitHubCollectionView.h"
#import "EnterUserViewController.h"
#import "UserDetailViewController.h"

@interface GitHubCollectionView ()
{
    NSMutableArray *users;
}

@end

@implementation GitHubCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    users = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
    
    NSLog(@"%@",users);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [users count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *userInfo = users[indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = [userInfo objectForKey:@"name"];
    
    UILabel *repoLabel = (UILabel *)[cell viewWithTag:3];
    repoLabel.text = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"public_repos"]];
    
    UILabel *hireableLabel = (UILabel *)[cell viewWithTag:4];
    NSString *hireableString = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"hireable"]];
    NSLog(@"%@",hireableString);
    hireableLabel.text = [hireableString  isEqual: @"1"] ? @"Yes" : @"No";
    
    UILabel *followersLabel = (UILabel *)[cell viewWithTag:5];
    followersLabel.text = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"followers"]];
    
    UILabel *followingLabel = (UILabel *)[cell viewWithTag:6];
    followingLabel.text = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"following"]];
    
    UILabel *usernameLabel = (UILabel *)[cell viewWithTag:7];
    usernameLabel.text = [userInfo objectForKey:@"login"];
    
    NSURL *avatarURL = [NSURL URLWithString:[userInfo objectForKey:@"avatar_url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:avatarURL];
    UIImage *image = [UIImage imageWithData:imageData];
    UIImageView *avatarView = (UIImageView *)[cell viewWithTag:2];
    avatarView.image = image;
    
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EnterUserSegue"])
    {
//        UINavigationController *navC = [segue destinationViewController];
        EnterUserViewController *enterUserVC = [segue destinationViewController];
        enterUserVC.users = users;
        
        
    }
    if ([segue.identifier isEqualToString:@"DetailViewSegue"])
    {
        UserDetailViewController *userDetailVC = (UserDetailViewController *)[segue destinationViewController];
        UICollectionViewCell *senderCell = (UICollectionViewCell *)sender;
        NSIndexPath *path = [self.collectionView indexPathForCell:senderCell];
//        ToDoItem *anItem = taskList[path.row];
//        anItem.taskName = senderCell.descriptionTextField.text;
//        anItem.done = senderCell.checkBoxButton.selected;
        NSDictionary *aUser = [users objectAtIndex:path.row];
        userDetailVC.userInfo = aUser;

        NSLog(@"%@",sender);
    }
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *aUser = [users objectAtIndex:indexPath.row];
//    UserDetailViewController *userDetailVC = [[UserDetailViewController alloc] init];
//    userDetailVC.userInfo = aUser;
//    [self.navigationController pushViewController:userDetailVC animated:YES];
    
    
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
