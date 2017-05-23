//
//  DetailViewController.h
//  LetsGOApp
//
//  Created by Marbet Ramon on 5/15/17.
//  Copyright © 2017 Ramon. All rights reserved.
//



#import "Annotation.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"


@interface DetailViewController : UIViewController <CLLocationManagerDelegate , MKMapViewDelegate>

@property (weak, nonatomic) Location *location;

#pragma mark - 
#pragma mark Class Methods
- (IBAction) setMap:(id)sender;

@end
