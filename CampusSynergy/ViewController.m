//
//  ViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //AddEventViewController *addEvent = [[AddEventViewController alloc] init];
    //[self.navigationController pushViewController:addEvent animated:YES];
    
    MKCoordinateRegion region = {{0.0, 0.0} , {0.0, 0.0}};
    
    region.center.latitude = 32.733332;
    region.center.longitude = -97.116288;
    region.span.latitudeDelta = .01f;
    region.span.longitudeDelta = .01f;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView setDelegate:self];
    
    //Construct the Polygons/Events objects
    
    NSArray *myArray = [self createPolygonCoordinateList:@"buildings"];
    
    if(myArray != nil){
        [self.mapView addOverlays:myArray];
    }
    else{
        UIAlertView *error =
        [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable To Load Map" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [error show];
    }
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay{
    
    MKPolygonView *v= nil;
    if ([overlay
         isKindOfClass:[MKPolygon class]]){
        v = [[MKPolygonView alloc] initWithPolygon:(MKPolygon *)overlay];
        v.fillColor = [[UIColor redColor] colorWithAlphaComponent:.1];
        v.strokeColor = [[UIColor redColor] colorWithAlphaComponent:.8];
        v.lineWidth = 2;
    }
    return v;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//The is the Add Event Button in the Main View Navigation Bar
- (IBAction)addEventPressed:(id)sender {
    
    //Check for a plist file for the user
    
    NSLog(@"AddEvent Button was pressed, checking to see if user loggedin");
    
    BOOL userLoggedIn = YES;
    
    if (userLoggedIn){
        NSLog(@"User is logged in, creating the addeventVC");
        //AddEventViewController *addEventVC = [[AddEventViewController alloc] init];
        AddEventViewController *addEventVC =
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddEventVC"];
        
        addEventVC.JSONVALUE = @"{event_name: \"Test Event\"}";
        
        [self.navigationController pushViewController:addEventVC animated:YES];
    }
    else{
        NSLog(@"User is not logged in, creating the loginVC");
        //LogInViewController *loginVC = [[LogInViewController alloc] init];
        LogInViewController *loginVC = 
        [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

//filePath is the xml file where the coordinates to draw the polygons are located
//Just gona leave this in the main
//Returns in array of MKPolygon coordinates
- (NSArray *)createPolygonCoordinateList: (NSString *)filePath{
    
    //Load the file and parse the xml
    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:filePath ofType:@"xml"];
    
    NSData *xml = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
    
    self.xmlParser = [[NSXMLParser alloc] initWithData:xml];
    
    self.xmlParser.delegate = self;
    
    if ([self.xmlParser parse]){
        NSLog(@"XML Parse Completed");
    }
    else{
        NSLog(@"XML Parse failed.");
    }
    
    /*
     CLLocationCoordinate2D points[4];
     
     points[0] = CLLocationCoordinate2DMake(32.72624963038879, -97.11853066639901);
     points[1] = CLLocationCoordinate2DMake(32.72607725216783, -97.11852939502279);
     points[2] = CLLocationCoordinate2DMake(32.72607130545389, -97.11832532690336);
     points[3] = CLLocationCoordinate2DMake(32.72624865539677, -97.11832026353882);
     
     MKPolygon* coordinates = [MKPolygon polygonWithCoordinates:points count:4];
     */
    
    // NSLog(@"%@", self.rootElement.subElements);
    
    NSMutableArray *mutableOverlaysArray = [[NSMutableArray alloc] init];
    
    //each building
    for(XMLElement *aBuilding in self.rootElement.subElements){
        //NSLog(@"Building: %@", [aBuilding.attributes objectForKey:@"name"]);
        
        int numberOfPoints = [aBuilding.subElements count]/2;
        //NSLog(@"Building: %@, %i",[aBuilding.attributes objectForKey:@"name"], numberOfPoints );
        CLLocationCoordinate2D points[numberOfPoints];
        
        BOOL alternator = YES;
        int pointsIndex = 0;
        //if YES then lat else long
        for(int i = 0; i < [aBuilding.subElements count]; i++){
            
            if (alternator){
                alternator = NO;
            }
            else{
                XMLElement *lat = aBuilding.subElements[i - 1];
                XMLElement *longVal = aBuilding.subElements[i];
                //NSLog(@"Lat: %@", lat.text);
                //NSLog(@"Long: %@", longVal.text);
                //NSLog(@"%i", pointsIndex);
                points[pointsIndex] = CLLocationCoordinate2DMake([lat.text doubleValue], [longVal.text doubleValue]);
                pointsIndex++;
                alternator = YES;
            }
        }
    
        MKPolygon* coordinates = [MKPolygon polygonWithCoordinates:points count:numberOfPoints];
        [mutableOverlaysArray addObject:coordinates];
    }
    
    NSArray *myArray = [[NSArray alloc] initWithArray:mutableOverlaysArray];
    return myArray;
}

//XML Parser Delegate Functions
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    self.rootElement = nil;
    self.currentElementPointer = nil;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if(self.rootElement == nil) {
        self.rootElement = [[XMLElement alloc] init];
        self.currentElementPointer = self.rootElement;
    }
    else{
        XMLElement *newElement = [[XMLElement alloc] init];
        newElement.parent = self.currentElementPointer;
        [self.currentElementPointer.subElements addObject:newElement];
        self.currentElementPointer = newElement;
    }
    
    self.currentElementPointer.name = elementName;
    self.currentElementPointer.attributes = attributeDict;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([self.currentElementPointer.text length] > 0){
        self.currentElementPointer.text = [self.currentElementPointer.text stringByAppendingString:string];
    }
    else{
        self.currentElementPointer.text = string;
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    self.currentElementPointer = self.currentElementPointer.parent;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    self.currentElementPointer = nil;
}

@end
