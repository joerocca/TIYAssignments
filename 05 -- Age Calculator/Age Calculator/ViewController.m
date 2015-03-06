//
//  ViewController.m
//  Age Calculator
//
//  Created by Joe Rocca on 3/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerViewController.h"

@interface ViewController ()
{
    NSInteger age;
    NSDateFormatter *dateFormatter;
    NSDate *chosenBirthDate;
    
}

@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;


- (IBAction)calculateAge:(UIButton *)sender;

-(void)findAge;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 1.png"]];
    
    

    
    
    self.title =@"Age Calculator";
    
 
    
    
    // currentDateLabel set here
    
    dateFormatter =[[NSDateFormatter alloc] init];
    
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMddyyyy" options:0 locale:[NSLocale currentLocale]];
    
    [dateFormatter setDateFormat: dateFormat];
    
    self.currentDateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    // age value set here
    
    
    
    
    //birth date label set here
    
    
    self.ageLabel.text = [NSString stringWithFormat:@"---"];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Navigation 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDestinationDatePickerSegue"])
    {
        DatePickerViewController *timePickerVC = (DatePickerViewController *)[segue destinationViewController];
        
        timePickerVC.delegate = self;
        
    }
    
}



-(void)birthDayWasChosen:(NSDate *)birthDate
{
    self.birthDateLabel.text = [dateFormatter stringFromDate:birthDate];
    chosenBirthDate = birthDate;
}
        
        
        
        
        

- (IBAction)calculateAge:(UIButton *)sender
{
    if (chosenBirthDate)
    {
    [self findAge];
    }
}






-(void)findAge
{
    
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *birthdayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitYear fromDate:chosenBirthDate];
    
    age = todayComponents.year - birthdayComponents.year;
    
    if(todayComponents.month < birthdayComponents.month)
    {
        age = age - 1;
    }
    else if (todayComponents.month == birthdayComponents.month)
    {
        if (todayComponents.day < birthdayComponents.day)
        {
            age = age -1;
        }
    }
    
    
    
    self.ageLabel.text = [NSString stringWithFormat:@"%ld", (long)age];




}





@end
