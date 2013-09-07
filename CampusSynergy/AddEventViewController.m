//
//  AddEventViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AddEventViewController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController{
    NSArray *buildingPickerValues;
    UIPickerView *buildingPickerView;
    UIToolbar *buildingToolbar;
    
    /*
    NSArray *roomPickerValues;
    UIPickerView *roomPickerView;
    UIToolbar *roomToolbar;
    */
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if( [textField tag] == [[self eventTitleTextField] tag]){
        [[self eventTitleTextField] resignFirstResponder];
        return YES;
    }
    else if( [textField tag] == [[self eventDescriptionTextField] tag]){
        [[self eventDescriptionTextField] resignFirstResponder];
        return YES;
    }
    else if ([textField tag] == [[self roomStringInput] tag]){
        [[self roomStringInput] resignFirstResponder];
        return YES;
    }
    else{
        return YES;
    }
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag == self.buildingTextField.tag){
        self.buildingTextField.textColor = [UIColor blackColor];
        self.buildingTextField.text = buildingPickerValues[0];
    }
    /*
    else if(textField.tag == self.roomNumberTextField.tag){
        self.roomNumberTextField.textColor = [UIColor blackColor];
        self.roomNumberTextField.text = roomPickerValues[0];
    }
     */
    else{
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Add Event";
    
    self.eventTitleTextField.delegate= self;
    self.eventDescriptionTextField.delegate = self;
    self.buildingTextField.delegate = self;
    //self.roomNumberTextField.delegate = self;
    self.roomStringInput.delegate=self;

    //Creating the building picker
    buildingPickerValues = [[NSArray alloc] initWithArray:[self allBuildings]];
    
    buildingPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,43, 320, 300)];
    buildingPickerView.delegate = self;
    buildingPickerView.dataSource = self;
    
    buildingPickerView.tag = 0;
    
    [buildingPickerView setShowsSelectionIndicator:YES];
    
    self.buildingTextField.inputView = buildingPickerView;
    
    buildingToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    buildingToolbar.barStyle = UIBarStyleBlackOpaque;
    [buildingToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *barTitle = [[UIBarButtonItem alloc] initWithTitle:@"Building"
                style:UIBarButtonItemStylePlain
                target:nil action:nil];
    
    [barItems addObject:barTitle];
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    [buildingToolbar setItems:barItems animated:YES];
    
    self.buildingTextField.inputAccessoryView = buildingToolbar;
    
    
    //creating room picker
    /*
    roomPickerValues = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];

    roomPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,43, 320, 400)];
    roomPickerView.delegate = self;
    roomPickerView.dataSource = self;
    
    [roomPickerView setShowsSelectionIndicator:YES];
    
    roomPickerView.tag = 1;
    
    //self.roomNumberTextField.inputView = roomPickerView;
    
    
    roomToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    roomToolbar.barStyle = UIBarStyleBlackOpaque;
    [roomToolbar sizeToFit];
    
    NSMutableArray *roomBarItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *roomBarTitle = [[UIBarButtonItem alloc] initWithTitle:@"Room"
                                       style:UIBarButtonItemStylePlain
                                        target:nil action:nil];
    
    [roomBarItems addObject:roomBarTitle];
    
    UIBarButtonItem *roomFlexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [roomBarItems addObject:roomFlexSpace];
    
    UIBarButtonItem *roomDoneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(roomPickerDoneClicked)];
    
    [roomBarItems addObject:roomDoneBtn];
    
    [roomToolbar setItems:roomBarItems animated:YES];
    
    self.roomNumberTextField.inputAccessoryView = roomToolbar;
     */
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Room picker
/*
- (void)roomPickerDoneClicked{
    [self.roomNumberTextField resignFirstResponder];
}
*/

//building picker
- (void)pickerDoneClicked{
    
    NSLog(@"Building picker Done clicked");
    [self.buildingTextField resignFirstResponder];
   // buildingToolbar.hidden = YES;
   // buildingPickerView.hidden = YES;
    
}

//This is the number of columns the picker should display
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [buildingPickerValues count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
        NSLog(@"row: %i", row);
        return [buildingPickerValues objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.buildingTextField.text = [buildingPickerValues objectAtIndex:row];
}
- (IBAction)inputTimeNextButton:(id)sender {
    
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    if([[[self eventDescriptionTextField] text] isEqualToString:@""]){
        
        [errorAlert setTitle:@"Event Description Error."];
        [errorAlert setMessage:@"Invalid Input for event description."];
        [errorAlert show];
    }
    else if([[[self eventTitleTextField] text] isEqualToString:@""]){
        
        [errorAlert setTitle:@"Event Title Error."];
        [errorAlert setMessage:@"Invalid Input for event title."];
        [errorAlert show];
    }
    else if([[[self buildingTextField]text] isEqualToString:@"Choose a building..." ]){
        
        [errorAlert setTitle:@"Building name Error."];
        [errorAlert setMessage:@"Invalid Input for building."];
        [errorAlert show];
    }
    /*
    else if([[[self roomNumberTextField] text] isEqualToString:@"Choose a room..."]){
        [errorAlert setTitle:@"Room input error."];
        [errorAlert setMessage:@"Invalid Input for room."];
        [errorAlert show];
    }
     */
    else if ([[[self roomStringInput] text] isEqualToString:@""]){
        [errorAlert setTitle:@"Enter a room."];
        [errorAlert setMessage:@"Please enter a room."];
        [errorAlert show];
    }
    else {
        AddEventTimesViewController *addEventTimesVC =
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddEventTimesVC"];
        
        //addEventTimesVC.app_id = [self app_id];
        //addEventTimesVC.rest_id = [self rest_id];
        
        addEventTimesVC.eventTitle = [[self eventTitleTextField] text];
        addEventTimesVC.eventDescription = [[self eventDescriptionTextField] text];
        addEventTimesVC.buildingString = [[self buildingTextField] text];
        //addEventTimesVC.roomString = [[self roomNumberTextField] text];
        addEventTimesVC.fieldRoomString = [[self roomStringInput] text];
        addEventTimesVC.publisher = [self publisher];
        
        [self.navigationController pushViewController:addEventTimesVC animated:YES];
    }
}
@end
