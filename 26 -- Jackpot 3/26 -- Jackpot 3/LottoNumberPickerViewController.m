//
//  ViewController.m
//  26 -- Jackpot 3
//
//  Created by Joe Rocca on 4/22/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "LottoNumberPickerViewController.h"
#import "Ticket.h"

@interface LottoNumberPickerViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSNumber *firstNumber;
    NSNumber *secondNumber;
    NSNumber *thirdNumber;
    NSNumber *fourthNumber;
    NSNumber *fifthNumber;
    NSNumber *sixthNumber;
}

@property (weak, nonatomic) IBOutlet UIPickerView *lottoNumberPicker;
- (IBAction)SearchTicketsButton:(UIButton *)sender;



@end

@implementation LottoNumberPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerView data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 53;
}

#pragma mark - UIPickerView delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 40.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld", (long)row + 1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            firstNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 1:
            secondNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 2:
            thirdNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 3:
            fourthNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 4:
            fifthNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 5:
            sixthNumber = [NSNumber numberWithInteger:row+1];
            break;
            
        default:
            break;
    }
}





- (IBAction)SearchTicketsButton:(UIButton *)sender
{
    Ticket *winningTicket = [Ticket ticketUsingArray:@[firstNumber, secondNumber, thirdNumber, fourthNumber, fifthNumber, sixthNumber]];
    [self.delegate winningTicketWasAdded:winningTicket];
}


@end
