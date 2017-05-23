//
//  Annotation.h
//  LetsGOApp
//
//  Created by Marbet Ramon on 5/17/17.
//  Copyright © 2017 Ramon. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Annotation : NSObject<MKAnnotation> {

    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D coordinate;
    
}

@property(nonatomic, copy) NSString *title;
@property(nonatomic,copy) NSString *subtitle;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
