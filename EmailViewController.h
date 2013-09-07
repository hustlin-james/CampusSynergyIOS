//
//  EmailViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 9/7/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> 
#import <MessageUI/MessageUI.h>

@interface EmailViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

- (IBAction)sendEmailToMobi:(id)sender;

@end
