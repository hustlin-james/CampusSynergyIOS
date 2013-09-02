//
//  AddEventTimesViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AddEventTimesViewController.h"

@interface AddEventTimesViewController (){
    //duration in hours 
    NSArray *durationPickerValues;
    UIPickerView *durationPickerView;
    UIToolbar *durationToolbar;
    
    
}

@end

@implementation AddEventTimesViewController

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
    
    //create the duration picker
    [self createPickerForDuration];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createPickerForDuration{
    durationPickerValues = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    
    durationPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,43, 320, 480)];
    durationPickerView.delegate = self;
    durationPickerView.dataSource = self;
    
    durationPickerView.tag = 2;
    
    [durationPickerView setShowsSelectionIndicator:YES];
    
    self.durationField.inputView = durationPickerView;
    
    durationToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    durationToolbar.barStyle = UIBarStyleBlackOpaque;
    [durationToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(durationDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    [durationToolbar setItems:barItems animated:YES];
    
    self.durationField.inputAccessoryView = durationToolbar;

}

- (void)durationDoneClicked{
    [self.durationField resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if([pickerView tag] == 0){
        return 1;
    }
    else if ([pickerView tag] == 1){
        return 1;
    }
    else{
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if( [pickerView tag] == 0){
        //return [buildingPickerValues count];
    }
    else if ([pickerView tag] == 1){
        //return [roomPickerValues count];
    }
    else{
        return [durationPickerValues count];
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if([pickerView tag] == 0){
        //return [buildingPickerValues objectAtIndex:row];
    }
    else if ([pickerView tag] == 1){
        //return [roomPickerValues objectAtIndex:row];
    }
    else{
        return [durationPickerValues objectAtIndex:row];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView tag] == 0){
        //self.buildingTextField.text = [buildingPickerValues objectAtIndex:row];
    }
    else if ([pickerView tag] == 1){
        //self.roomNumberTextField.text = [roomPickerValues objectAtIndex:row];
    }
    else{
        self.durationField.text = [durationPickerValues objectAtIndex:row];
    }
}

@end
