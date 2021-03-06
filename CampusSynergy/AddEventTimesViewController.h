//
//  AddEventTimesViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsData.h"
#import "EventDetailsViewController.h"

@interface AddEventTimesViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property(copy, nonatomic) NSString *eventTitle;
@property(copy, nonatomic) NSString *eventDescription;
@property(copy, nonatomic) NSString *buildingString;
@property(copy, nonatomic) NSString *publisher;
//this is the string input for room
@property(copy, nonatomic) NSString *fieldRoomString;

//UITextField *startingTime in string form
@property(copy, nonatomic) NSString *starttimeAsString;
//Text Fields
@property (weak, nonatomic) IBOutlet UITextField *startingTime;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *durationField;

//Button
- (IBAction)submitButton:(id)sender;

@end
