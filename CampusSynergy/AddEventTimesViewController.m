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
    
    self.title = @"Add Event";
    self.startingTime.delegate = self;
    self.dateField.delegate = self;
    self.durationField.delegate=self;
    
    //Starting time picker
    [self createStarttimePicker];
    //Date picker
    [self createDatePicker];
    //create the duration picker
    [self createPickerForDuration];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSDateFormatter *timeFieldsOutputFormat =[[NSDateFormatter alloc] init];
    if(textField.tag == self.startingTime.tag){
        NSLog(@"Started Editing starting Time field");
        self.startingTime.textColor = [UIColor blackColor];
        //[DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        //NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]])
        [timeFieldsOutputFormat setDateFormat:@"hh:mm a"];
        self.startingTime.text = [timeFieldsOutputFormat stringFromDate:[NSDate date]];
    }
    else if(textField.tag == self.dateField.tag){
        NSLog(@"Started Editing starting Time field");
        self.dateField.textColor = [UIColor blackColor];
        //[DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        //NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]])
        [timeFieldsOutputFormat setDateFormat:@"yyyy-MM-dd"];
        self.dateField.text = [timeFieldsOutputFormat stringFromDate:[NSDate date]];
    }
    else if(textField.tag == self.durationField.tag){
        NSLog(@"Started editing duration field.");
        self.durationField.textColor = [UIColor blackColor];
        self.durationField.text = @"1";
    }
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
   
    UIBarButtonItem *barTitle = [[UIBarButtonItem alloc] initWithTitle:@"Start Time"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil action:nil];
    
    [barItems addObject:barTitle];
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
    [df2 setDateFormat:@"hh:mm a"];
    
    NSString *dateString = [df2 stringFromDate:[datePicker date]];
    self.starttimeAsString = dateString;
    
    
    NSLog(@"starting time is: %@",[self starttimeAsString]);
    self.startingTime.text = dateString;
    
    
    //Start Time with dot, for the timeStart field
    NSDateFormatter *startTimeWithDotFormmater = [[NSDateFormatter alloc] init];
    [startTimeWithDotFormmater setDateFormat:@"h.mm"];
    startingTimeWithDot = [startTimeWithDotFormmater stringFromDate:[datePicker date]];

    
    //another form of starting time fro the iso date to send in the json
    NSDateFormatter *df3 = [[NSDateFormatter alloc]init];
    //HH is 24 hour time
    [df3 setDateFormat:@"HH:mm:ss"];
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
    
    UIBarButtonItem *barTitle = [[UIBarButtonItem alloc] initWithTitle:@"Date"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil action:nil];
    
    [barItems addObject:barTitle];
    
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
    
    UIBarButtonItem *barTitle = [[UIBarButtonItem alloc] initWithTitle:@"Duration"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil action:nil];
    
    [barItems addObject:barTitle];
    
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

//Only affects the duration picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [durationPickerValues count];
}
//Only affects the duration picker
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [durationPickerValues objectAtIndex:row];
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
        self.durationField.textColor = [UIColor blackColor];
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
        
        
        //yyyy-MM-ddTHH:mm:ss
        
        NSString *iso_string = [[NSString alloc] initWithFormat:@"%@T%@",[[self dateField] text], startingTimeWithSeconds];
        
        NSDateFormatter *isoStringFormatter = [[NSDateFormatter alloc] init];
        [isoStringFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
        NSDate *convertedDate = [isoStringFormatter dateFromString: iso_string];
        
        /*
        NSString *myFirstString = [isoStringFormatter stringFromDate:convertedDate];
        NSLog(@"myFirstString: %@", myFirstString);
         */
        //NSString *aDate = [NSString :(NSString *)convertedDate];
        //NSLog(@"aDate: %@", aDate);
        
        /*
        NSDateFormatter *aFormat = [[NSDateFormatter alloc]init];
        [aFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
        NSString *myString = [aFormat stringFromDate:convertedDate];
        NSLog(@"myString: %@", myString);
        */
        /*
        
        NSDate *
        dateFromString = [isoStringFormatter dateFromString:(NSString *)convertedDate];
        
        isoStringFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *newDateString = [isoStringFormatter stringFromDate:dateFromString];
        NSLog(@"newDateString: %@", newDateString);
        */
        
        //NSString *result = [aDate substringToIndex:20];
        //NSLog(@"%@", result);
        //NSArray *results = [aDate componentsSeparatedByCharactersInSet:"@+"];
       // NSLog(@"%@", results);
        //iso_string = [NSString stringWithFormat:@"%@T%@", results[0], results[1]];
        
        //[isoStringFormatter setDateFormat:@"yyyy-MM-ddTHH:mm:ss"];
        //NSLog(@"converedDate as String: %@", [isoStringFormatter stringFromDate:convertedDate]);
        //iso_string = [isoStringFormatter stringFromDate:convertedDate];
        
        //NSLog(@"ConvertedDate: %@", convertedDate.description);
        NSString *convert = [[NSString alloc] initWithString:convertedDate.description];
        NSArray *results =[convert componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSLog(@"results[0]: %@", results[0]);
        NSLog(@"results[1]: %@", results[1]);
        
        NSLog(@"startingTimeWtihSeconds: %@", startingTimeWithSeconds);
        
        NSLog(@"iso_string: %@", iso_string);
        
        iso_string = [NSString stringWithFormat:@"%@T%@", results[0], results[1]];
        NSLog(@"new iso_string: %@", iso_string);
        
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
        
        //These couple lines below adds stuff to the parse database comment out for testing purposes
        //uncomment after testing
        /*
        NSData *response = [myPOSTEvent uploadDataToParseWithREST:myJsonString];
         */
        
        //Check the response was successfull
        //{"createdAt":"2013-09-03T02:49:38.520Z","objectId":"pr0qXj16gf"}
        
        //uncomment after testing
        /*
        NSError *json_error;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&json_error];
        
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        NSString *createdAt = (NSString *)[deserializedDictionary objectForKey:@"createdAt"];
         */
        
        BOOL addToDBSuccessful = YES;
        
        //implement this after testing
        //Check for whether or not data was added to parse successfully
        //if (createdAt == nil || [createdAt isEqualToString:@""])
        
        if (addToDBSuccessful) {
            EventDetailsViewController *eventDetailsVC
            = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
            eventDetailsVC.navigationItem.hidesBackButton = YES;
            //Set the fields for the eventdetails object
            eventDetailsVC.eventTitleText = [self eventTitle];
            eventDetailsVC.eventDescriptionText = [self eventDescription];
            eventDetailsVC.eventRoomText = [self roomString];
            eventDetailsVC.eventBuildingText = [self buildingString];
            eventDetailsVC.publisherText = [self publisher];
            
            /*
             This event starts at 04:07 PM 09/06/2013 and it takes 11.0 hours
             to finish.
             */
            
            NSString *startTimeText = [[NSString alloc] initWithFormat:@"This event starts at %@ %@ and it takes %@ hours to finish", self.startingTime.text, self.dateField.text, self.durationField.text];
            
            eventDetailsVC.startTimeDescriptionText = startTimeText;
            
            [self.navigationController pushViewController:eventDetailsVC animated:YES];
            //NSLog(@"End of AddEventTimesVC");
        }
        else{
            
            //UIAlertView
        }
    }
    else{
        //UIAlertview for invalid input
    }
}
@end
