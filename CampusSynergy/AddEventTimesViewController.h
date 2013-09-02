//
//  AddEventTimesViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventTimesViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property(copy, nonatomic) NSString *eventTitle;
@property(copy, nonatomic) NSString *eventDescription;
@property(copy, nonatomic) NSString *buildingString;
@property(copy, nonatomic) NSString *roomString;

//Text Fields
@property (weak, nonatomic) IBOutlet UITextField *startingTime;

@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *durationField;

@end
