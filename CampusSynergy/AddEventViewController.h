//
//  AddEventViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventTimesViewController.h"

@interface AddEventViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property(copy, nonatomic) NSString *publisher;

- (IBAction)inputTimeNextButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *eventTitleTextField;

@property (weak, nonatomic) IBOutlet UITextField *eventDescriptionTextField;

@property (weak, nonatomic) IBOutlet UITextField *buildingTextField;
//@property (weak, nonatomic) IBOutlet UITextField *roomNumberTextField;

@property (copy, nonatomic) NSArray *allBuildings;

//String version of the room
@property (weak, nonatomic) IBOutlet UITextField *roomStringInput;

@end
