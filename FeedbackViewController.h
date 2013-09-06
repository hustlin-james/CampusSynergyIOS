//
//  FeedbackViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 9/6/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FeedbackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *feedbackInputView;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@end
