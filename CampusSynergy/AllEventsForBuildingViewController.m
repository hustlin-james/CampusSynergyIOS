//
//  AllEventsForBuildingViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AllEventsForBuildingViewController.h"

@interface AllEventsForBuildingViewController ()

@end

@implementation AllEventsForBuildingViewController

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
	// Do any additional setup after loading the view
    

    self.buildingEventsTable.dataSource = self;
    self.buildingEventsTable.delegate = self;
    
    NSString *buildNameText = [[NSString alloc]
                               initWithFormat:@"All Events for building: %@", [self buildingNameString]];
    
    self.buildingName.text = buildNameText;
    self.title = [self buildingNameString];
    
    //parse objective C API
    //filter out all the non related buildings
    NSMutableArray *myParseEventsArray = [[NSMutableArray alloc]init];
    
    for(PFObject *event in [self parseEventArray]){
        if([[event objectForKey:@"bldName"] isEqualToString:
           [self buildingNameString]]){
            [myParseEventsArray addObject: event];
        }
    }
    self.parseEventArray = [[NSArray alloc] initWithArray:myParseEventsArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//This is pretty much how many tables cells should be generated
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //NSLog(@"Generating %d Table cells", (int)[self.eventsArray count]);
    
    //return [self.eventsArray count];
    return [self.parseEventArray count];
}

//Setings for a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //This is the identifier for the table cells, it is in the attributes thing
    NSString *cellIdentifier = @"EventsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    //new parse stuff
    NSString *parseEventString = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *parseSubTitle =[[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    
    [cell.textLabel setText:parseEventString];
    [cell.detailTextLabel setText: parseSubTitle];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventDetailsViewController *eventDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    
    eventDetailsVC.navigationItem.hidesBackButton = NO;
    //Set the all event properties
    
    //objective c parse library
    NSString *myEventsTitle
    = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    eventDetailsVC.eventTitleText = myEventsTitle;
    
    NSString *myEventDescription = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"longDescription"];
    eventDetailsVC.eventDescriptionText = myEventDescription;
    
    /*
    NSString *myRoomString = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"room"];
    eventDetailsVC.eventRoomText = myRoomString;
     */
    
    NSString *myBuildingString = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    eventDetailsVC.eventBuildingText = myBuildingString;
    
    eventDetailsVC.publisherText = [self username];
    
    NSString *myDuration = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"duration"];
    
    NSDate *parseDate = [[self.parseEventArray objectAtIndex:indexPath.row]
                         objectForKey:@"date"];
    
    NSLog(@"parseDate: %@", parseDate);
    NSLog(@"parseDate description: %@", parseDate.description);
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *myParseTime = [timeFormatter stringFromDate:parseDate];
    
    [timeFormatter setDateFormat:@"hh:mm a"];
    NSString *myParseDate = [timeFormatter stringFromDate:parseDate];
    
    
    NSString *newRoomString = [[self.parseEventArray objectAtIndex:indexPath.row]
                               objectForKey:@"roomString"];
    
    NSString *myStartTimeText = [[NSString alloc] initWithFormat:@"This event starts at %@ %@, it takes %@ hours to finish and is in room %@.", myParseTime, myParseDate, myDuration, newRoomString];
    eventDetailsVC.startTimeDescriptionText = myStartTimeText;
    
    [self.navigationController pushViewController:eventDetailsVC animated:YES];
}

@end
