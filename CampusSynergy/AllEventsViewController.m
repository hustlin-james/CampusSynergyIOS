//
//  AllEventsViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AllEventsViewController.h"

@interface AllEventsViewController ()

@end

@implementation AllEventsViewController

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
    
    //Event change this to dynamically retrieve all the events
    //from the parsed server
    
    NSLog(@"Creating the dataSource and the delegate for the view cells.");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    //Temp Array of Events
    
    self.eventsArray = [[ NSArray alloc] initWithObjects:
                     @"Event 1",
                     @"Event 2",
                     @"Event 3",
                     @"Event 4",
                     @"Event 5",
                     @"Event 6",
                        nil];
    
    if (self.eventsArray != nil && [self.eventsArray count] > 0){
        NSLog(@"Events Array Created");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//This is pretty much how many tables cells should be generated
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"Generating %d Table cells", (int)[self.eventsArray count]);
    
    return [self.eventsArray count];
}

//Setings for a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //This is the identifier for the table cells, it is in the attributes thing
    NSString *cellIdentifier = @"EventsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *eventString = [self.eventsArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:eventString];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventDetailsViewController *eventDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AllEventsVC"];
    
        //Set properties of the EventDetailsViewController Object
    [self.navigationController pushViewController:eventDetailsVC animated:YES];
}

@end
