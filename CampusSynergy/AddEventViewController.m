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
    
    
    NSArray *roomPickerValues;
    UIPickerView *roomPickerView;
    UIToolbar *roomToolbar;
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
    else{
        return YES;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        self.view.backgroundColor = [UIColor whiteColor];
        //self.navigationController.navigationItem.title = @"Add Event";
        self.title = @"Add Event";
        
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.eventTitleTextField.delegate= self;
    self.eventDescriptionTextField.delegate = self;
    
    
    //Creating the building picker
    buildingPickerValues = [[NSArray alloc] initWithObjects:@"ERB", @"AL", @"NH", nil];
    
    buildingPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,43, 320, 480)];
    buildingPickerView.delegate = self;
    buildingPickerView.dataSource = self;
    
    buildingPickerView.tag = 0;
    
    [buildingPickerView setShowsSelectionIndicator:YES];
    
    self.buildingTextField.inputView = buildingPickerView;
    
    buildingToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    buildingToolbar.barStyle = UIBarStyleBlackOpaque;
    [buildingToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    [buildingToolbar setItems:barItems animated:YES];
    
    self.buildingTextField.inputAccessoryView = buildingToolbar;
    
    
    //creating
    roomPickerValues = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    
    roomPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,43, 320, 480)];
    roomPickerView.delegate = self;
    roomPickerView.dataSource = self;
    
    [roomPickerView setShowsSelectionIndicator:YES];
    
    roomPickerView.tag = 1;
    
    self.roomNumberTextField.inputView = roomPickerView;
    
    roomToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    roomToolbar.barStyle = UIBarStyleBlackOpaque;
    [roomToolbar sizeToFit];
    
    NSMutableArray *roomBarItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *roomFlexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [roomBarItems addObject:roomFlexSpace];
    
    UIBarButtonItem *roomDoneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(roomPickerDoneClicked)];
    
    [roomBarItems addObject:roomDoneBtn];
    
    [roomToolbar setItems:roomBarItems animated:YES];
    
    self.roomNumberTextField.inputAccessoryView = roomToolbar;

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)roomPickerDoneClicked{
    [self.roomNumberTextField resignFirstResponder];
}

- (void)pickerDoneClicked{
    
    NSLog(@"Building picker Done clicked");
    
    [self.buildingTextField resignFirstResponder];
    
   // buildingToolbar.hidden = YES;
   // buildingPickerView.hidden = YES;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if([pickerView tag] == 0){
        return 1;
    }
    else{
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if( [pickerView tag] == 0){
        return [buildingPickerValues count];
    }
    else{
        return [roomPickerValues count];
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if([pickerView tag] == 0){
        return [buildingPickerValues objectAtIndex:row];
    }
    else{
        return [roomPickerValues objectAtIndex:row];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView tag] == 0){
        self.buildingTextField.text = [buildingPickerValues objectAtIndex:row];
    }
    else{
        self.roomNumberTextField.text = [roomPickerValues objectAtIndex:row];
    }
}


- (IBAction)inputTimeNextButton:(id)sender {
    
    BOOL inputValid = YES;
    
    if (inputValid) {
        AddEventTimesViewController *addEventTimesVC =
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddEventTimesVC"];
        
        [self.navigationController pushViewController:addEventTimesVC animated:YES];
    }
    else{
        //Alert Invalid input
    }
}
@end
