//
//  AddEventTimesViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsData.h"

@interface AddEventTimesViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (copy, nonatomic) NSString *app_id;
@property (copy, nonatomic) NSString *rest_id;

@property(copy, nonatomic) NSString *eventTitle;
@property(copy, nonatomic) NSString *eventDescription;
@property(copy, nonatomic) NSString *buildingString;
@property(copy, nonatomic) NSString *roomString;
@property(copy, nonatomic) NSString *publisher;

//UITextField *startingTime in string form
@property(copy, nonatomic) NSString *starttimeAsString;

//Text Fields
@property (weak, nonatomic) IBOutlet UITextField *startingTime;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *durationField;

//Button
- (IBAction)submitButton:(id)sender;

@end
