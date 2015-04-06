//
//  DetailSearchResultViewController.m
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DetailSearchResultViewController.h"
#import "MapObject.h"
#import "CoreDataStack.h"
#import "Venue.h"


#define MAP_DISPLAY_SCALE 0.5 * 1609.344

@import MapKit;

@interface DetailSearchResultViewController ()
{
    BOOL favorited;
}


@property (weak, nonatomic) IBOutlet UILabel *venueName;
@property (weak, nonatomic) IBOutlet UILabel *venueDescription;
@property (weak, nonatomic) IBOutlet UILabel *streetAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *CityStateZip;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (IBAction)starTapped:(UIBarButtonItem *)sender;



@end

@implementation DetailSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"unselectedStar"] style:UIBarButtonItemStylePlain target:self action:@selector(starTapped:)];
    
    NSString *lat = self.venueInfo [@"location"][@"lat"];
    NSString *lng = self.venueInfo [@"location"][@"lng"];
    self.latitude = [lat doubleValue];
    self.longitude = [lng doubleValue];
    self.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    self.aMap = [[MapObject alloc] initWithCoordinate:self.coordinate];
    
    favorited = NO;
    
    
    self.venueName.text = self.venueInfo [@"name"];
    self.venueDescription.text = [self.venueInfo[@"categories"]objectAtIndex:0][@"name"];
    self.streetAddressLabel.text = [self.venueInfo[@"location"][@"formattedAddress"] objectAtIndex:0];
    self.CityStateZip.text = [self.venueInfo [@"location"][@"formattedAddress"] objectAtIndex:1];
    self.phoneNumberLabel.text = self.venueInfo [@"contact"][@"formattedPhone"];
//        NSString *iconPrefix = [self.venueInfo [@"categories"]objectAtIndex:0][@"icon"][@"prefix"];
//    NSString *iconSuffix = [self.venueInfo [@"categories"]objectAtIndex:0][@"icon"][@"suffix"];
//    NSString *icon = [NSString stringWithFormat:@"%@%d%@",iconPrefix,64,iconSuffix];
//    NSURL *iconURL = [NSURL URLWithString:icon];
//    NSData *imageData = [NSData dataWithContentsOfURL:iconURL];
//    UIImage *image = [UIImage imageWithData:imageData];
//    self.iconView.image = image;
//    NSLog(@"%@",icon);
    
    [self configureMapView];
    
    NSLog(@"%@",self.venueInfo);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.aMap coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE); //setter
    [self.mapView setRegion:viewRegion]; //getter
    [self.mapView addAnnotation:self.aMap]; //has MKAnnotation protocol
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MapObject class]])
    {
        static NSString * const identifier = @"MapAnnotation";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
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
        Venue *aVenue = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:self.cdStack.managedObjectContext];
        
        aVenue.name = self.venueInfo [@"name"];
        aVenue.streetAddress = [self.venueInfo[@"location"][@"formattedAddress"] objectAtIndex:0];
        aVenue.city = [self.venueInfo [@"location"][@"formattedAddress"] objectAtIndex:1];
        NSString *iconPrefix = [self.venueInfo [@"categories"]objectAtIndex:0][@"icon"][@"prefix"];
        NSString *iconSuffix = [self.venueInfo [@"categories"]objectAtIndex:0][@"icon"][@"suffix"];
        NSString *icon = [NSString stringWithFormat:@"%@%@%d%@",iconPrefix,@"bg_",44,iconSuffix];
        aVenue.icon = icon;
        [self saveCoreDataUpdates];
        
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"selectedStar"]];
        favorited = YES;
        
    }
    
    
    

    
}



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





@end
