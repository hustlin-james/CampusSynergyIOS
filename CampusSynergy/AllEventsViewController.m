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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//This is pretty much how many tables cells should be generated
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"Generating %d Table cells", (int)[self.eventsArray count]);
    
    //return [self.eventsArray count];
    return [self.parseEventObjects count];
}

//Setings for a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //This is the identifier for the table cells, it is in the attributes thing
    NSString *cellIdentifier = @"EventsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    /*
    NSString *eventString =
    [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSString *subLabel =
    [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    */
    
    //new parse event API
    NSLog(@"parse event api.");
    NSString *myEventString =
    [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSString *mySubLabel =
    [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    
    
    [cell.textLabel setText:myEventString];
    [cell.detailTextLabel setText: mySubLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventDetailsViewController *eventDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    
    eventDetailsVC.navigationItem.hidesBackButton = NO;
    
    //new parse API
    NSString *myEventsTitle
    = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"title"];
    eventDetailsVC.eventTitleText = myEventsTitle;
    
    NSString *myEventDescription = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"longDescription"];
    eventDetailsVC.eventDescriptionText = myEventDescription;
    
    /*
    NSString *myRoomString = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"room"];
    eventDetailsVC.eventRoomText = myRoomString;
     */
    
    NSString *myBuildingString = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    eventDetailsVC.eventBuildingText = myBuildingString;
    
    eventDetailsVC.publisherText = [self username];

    NSString *myDuration = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey:@"duration"];
    
    NSDate *parseDate = [[self.parseEventObjects objectAtIndex:indexPath.row]
                          objectForKey:@"date"];
    
    NSLog(@"parseDate: %@", parseDate);
    NSLog(@"parseDate description: %@", parseDate.description);
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *myParseTime = [timeFormatter stringFromDate:parseDate];
    
    [timeFormatter setDateFormat:@"hh:mm a"];
    NSString *myParseDate = [timeFormatter stringFromDate:parseDate];
    
    NSString *newRoomString = [[self.parseEventObjects objectAtIndex:indexPath.row] objectForKey: @"roomString"];
    
    NSString *myStartTimeText = [[NSString alloc] initWithFormat:@"This event starts at %@ %@, it takes %@ hours to finish and is in room %@.", myParseTime, myParseDate, myDuration, newRoomString];
    eventDetailsVC.startTimeDescriptionText = myStartTimeText;
    
    [self.navigationController pushViewController:eventDetailsVC animated:YES];
}

@end
