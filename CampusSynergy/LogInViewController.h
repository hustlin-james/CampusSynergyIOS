//
//  LogInViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventViewController.h"

@interface LogInViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (copy, nonatomic) NSString *app_id;
@property (copy, nonatomic) NSString *rest_id;

- (IBAction)loginSubmitButton:(id)sender;

@end
