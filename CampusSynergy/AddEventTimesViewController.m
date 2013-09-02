//
//  AddEventTimesViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AddEventTimesViewController.h"

@interface AddEventTimesViewController (){
    //duration in hours 
    NSArray *durationPickerValues;
    UIPickerView *durationPickerView;
    UIToolbar *durationToolbar;
}

@end

@implementation AddEventTimesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    //Date picker
    [self createDatePicker];
  
    //create the duration picker
    [self createPickerForDuration];
}

- (void)createDatePicker{
    
    UIToolbar *dateToolbar;
    
    UIDatePicker* datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateField.inputView = datePicker;
    
    dateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    dateToolbar.barStyle = UIBarStyleBlackOpaque;
    [dateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dateDoneButtonClicked)];
    
    [barItems addObject:doneBtn];
    
    [dateToolbar setItems:barItems animated:YES];
    
    self.dateField.inputAccessoryView = dateToolbar;
}

-(void)dateDoneButtonClicked{
    NSLog(@"Date Done Button was clicked.");
    
    //Set the textfield to the inputted date
    
    [self.dateField resignFirstResponder];
    
}
-(void)datePickerChanged:(UIDatePicker*)datePicker{
    NSLog(@"Hit datepicker changed");
    
    //NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    //[df1 setDateFormat:@"yyyy-d-mm hh:mm:ss ZZZZ"];
    //NSDate *newDate = [df1 dateFromString:currentSring];
    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"yyyy-d-mm"];
    NSString *dateString = [df2 stringFromDate:[datePicker date]];
    NSLog(@"date is: %@",dateString);
    self.dateField.text = dateString;
    //NSDate *formattedDate = [df2 dateFromString:dateString];
    //NSLog(@"%@", [datePicker date]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPickerForDuration{
    durationPickerValues = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    
    durationPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,43, 320, 480)];
    durationPickerView.delegate = self;
    durationPickerView.dataSource = self;
    
    durationPickerView.tag = 2;
    
    [durationPickerView setShowsSelectionIndicator:YES];
    
    self.durationField.inputView = durationPickerView;
    
    durationToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    durationToolbar.barStyle = UIBarStyleBlackOpaque;
    [durationToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(durationDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    [durationToolbar setItems:barItems animated:YES];
    
    self.durationField.inputAccessoryView = durationToolbar;

}

- (void)durationDoneClicked{
    [self.durationField resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if([pickerView tag] == 0){
        return 1;
    }
    else if ([pickerView tag] == 1){
        return 1;
    }
    else{
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if( [pickerView tag] == 0){
        //return [buildingPickerValues count];
    }
    else if ([pickerView tag] == 1){
        //return [roomPickerValues count];
    }
    else{
        return [durationPickerValues count];
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if([pickerView tag] == 0){
        //return [buildingPickerValues objectAtIndex:row];
    }
    else if ([pickerView tag] == 1){
        //return [roomPickerValues objectAtIndex:row];
    }
    else{
        return [durationPickerValues objectAtIndex:row];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView tag] == 0){
        //self.buildingTextField.text = [buildingPickerValues objectAtIndex:row];
    }
    else if ([pickerView tag] == 1){
        //self.roomNumberTextField.text = [roomPickerValues objectAtIndex:row];
    }
    else{
        self.durationField.text = [durationPickerValues objectAtIndex:row];
    }
}

- (IBAction)submitButton:(id)sender {
    //When user cliecks the submit button
    //check data and then send the data to parse
    //then redirect to the events details page
    BOOL validateInput = YES;
    
    if (validateInput){
        //Send data to parse
    }
    else{
        //UIAlertview for invalid input
    }
}
@end
