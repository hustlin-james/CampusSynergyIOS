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
    
    
    //Starting time with seconds
    NSString *startingTimeWithSeconds;
    
    //Start time with dot
    NSString *startingTimeWithDot;
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
    //Starting time picker
    [self createStarttimePicker];
    
    //Date picker
    [self createDatePicker];
    
    //create the duration picker
    [self createPickerForDuration];
}

//Hours and mintues, PM, AM
- (void)createStarttimePicker{
    
    UIToolbar *starttimeToolbar;
    UIDatePicker* starttimePicker = [[UIDatePicker alloc] init];
    starttimePicker.datePickerMode = UIDatePickerModeTime;
    [starttimePicker addTarget:self action:@selector(startPickerChanged:) forControlEvents:UIControlEventValueChanged];
    self.startingTime.inputView = starttimePicker;
    
    starttimeToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    starttimeToolbar.barStyle = UIBarStyleBlackOpaque;
    [starttimeToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(startTimeDoneButtonClicked)];
    
    [barItems addObject:doneBtn];
    
    [starttimeToolbar setItems:barItems animated:YES];
    
    self.startingTime.inputAccessoryView = starttimeToolbar;
    
}
- (void)startTimeDoneButtonClicked{
    NSLog(@"Start Time picker done button was clicked.");
    [self.startingTime resignFirstResponder];
}

- (void)startPickerChanged:(UIDatePicker*)datePicker{
    NSLog(@"Start Time picker was changed.");
    
    NSLog(@"%@", [datePicker date]);
    
    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"hh:mm"];
    NSString *dateString = [df2 stringFromDate:[datePicker date]];
    self.starttimeAsString = dateString;
    NSLog(@"starting time is: %@",[self starttimeAsString]);
    self.startingTime.text = dateString;
    
    
    //Start Time with dot
     NSDateFormatter *startTimeWithDotFormmater = [[NSDateFormatter alloc] init];
     [startTimeWithDotFormmater setDateFormat:@"h.mm"];
     startingTimeWithDot = [startTimeWithDotFormmater stringFromDate:[datePicker date]];

    
    //another form of starting time
    NSDateFormatter *df3 = [[NSDateFormatter alloc]init];
    [df3 setDateFormat:@"hh:mm:ss"];
    startingTimeWithSeconds = [df3 stringFromDate:[datePicker date]];

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
    //[df2 setDateFormat:@"MMM dd, yyyy"];
    [df2 setDateFormat:@"yyyy-MM-dd"];
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
        NSLog(@"Input is valid");
        
        //Create the jsonString
        
        NSString *iso_string = [[NSString alloc] initWithFormat:@"%@T%@",[[self dateField] text],
                                           startingTimeWithSeconds];
        
        NSLog(@"iso_string: %@", iso_string);
        
        
        /*
         curl -X POST \
         -H "X-Parse-Application-Id: QuoI3WPv5g9LyP4awzhZEH8FvRKIgWgFEdFJSTmB" \
         -H "X-Parse-REST-API-Key: inV9LL0B01842cQsvjSr06fVAbse9T2CBRHa0yde" \
         -H "Content-Type: application/json" \
         -d '{"bldName":"AL", "date":{"__type": "Date","iso": "2013-09-03T09:38:30"}, "duration":2, "longDescription":"this is an event","publisher":"James Fielder", "room":2, "timeStart":09.38,"title":"test event"}' \
         https://api.parse.com/1/classes/campus_synergy
         */
        
        //{"__type": "Date","iso": "2011-08-21T18:02:52"}
        NSString *date_json = [[NSString alloc] initWithFormat:@"{\"__type\": \"Date\",\"iso\": \"%@\"}",iso_string];
        
        NSString * myJsonString = [[NSString alloc]
        initWithFormat:
        @"{\"bldName\":\"%@\", \"date\":%@, \"duration\":%@, \"longDescription\":\"%@\",",
                                   [self buildingString], date_json,
                                   [[self durationField] text],
                                   [self eventDescription]];
        
        myJsonString = [myJsonString stringByAppendingString:
        [NSString stringWithFormat:@"\"publisher\":\"%@\", \"room\":%@, \"timeStart\":%@,",
                         [self publisher], [self roomString], startingTimeWithDot]];
        
        myJsonString = [myJsonString stringByAppendingString:
        [NSString stringWithFormat:@"\"title\":\"%@\"", [self eventTitle]]];
                        
        myJsonString = [myJsonString stringByAppendingString:@"}"];
        
        NSLog(@"POST JSON: %@", myJsonString);
        
        EventsData *myPOSTEvent =[[EventsData alloc] initWithAppId:[self app_id] andRestID:[self rest_id]];
        
        NSData *response = [myPOSTEvent uploadDataToParseWithREST:myJsonString];
        //NSLog(@"%@", [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
        
        //Check the response was successfull
        //{"createdAt":"2013-09-03T02:49:38.520Z","objectId":"pr0qXj16gf"}
        NSError *json_error;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&json_error];
        
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        NSString *createdAt = (NSString *)[deserializedDictionary objectForKey:@"createdAt"];
        
        if (createdAt == nil || [createdAt isEqualToString:@""]){
            //UIAlert View saying error occured
        }
        else{
            //Redirected to a successful events page
        }
        
        
    }
    else{
        //UIAlertview for invalid input
    }
}
@end
