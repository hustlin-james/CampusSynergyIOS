//
//  EmailViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 9/7/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController

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
    
    [[self.inputTextView layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.inputTextView layer] setBorderWidth:1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard{
    [self.inputTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmailToMobi:(id)sender {
    
    NSString *body = self.inputTextView.text;
    
    NSString *appendedBody = @"CAMPUS SYNERGY FEEDBACK.\n";
    
    appendedBody = [appendedBody stringByAppendingString:body];
    
    NSLog(@"body message: %@", body);
    
    if(![body isEqualToString:@""]){
        NSLog(@"Send Button Pressed.");

        NSString *emailTitle = @"FEEDBACK (DON'T CHANGE) CSA";
        NSString *messageBody = appendedBody;

        NSArray *toRecipents = [NSArray arrayWithObject:@"uta.mobi@gmail.com" ];

        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];

        [self presentViewController:mc animated:YES completion:NULL];
    }
    else{
        UIAlertView *blankBody = [[UIAlertView alloc] initWithTitle:@"Empty Body" message:@"Please enter a message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [blankBody show];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch(result){
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            //NSLog(@"Mail sent");
            [self mailSentMessage];
            break;
        case MFMailComposeResultFailed:
            [self mailFailMessage: error];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)mailFailMessage: (NSError *)error{
    NSLog(@"mail sent failure: %@", [error localizedDescription]);
    UIAlertView *mailSent = [[UIAlertView alloc] initWithTitle:@"Failed." message:@"Failed to send message." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [mailSent show];
}
- (void)mailSentMessage{
    NSLog(@"Sent Mail");
    UIAlertView *mailSent = [[UIAlertView alloc] initWithTitle:@"Sent!" message:@"Mail has been sent." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [mailSent show];
}
@end
