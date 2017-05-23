//
//  DetailViewController.m
//  LetsGOApp
//
//  Created by Marbet Ramon dos Santos on 5/15/17.
//  Copyright © 2017 Ramon. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "DetailViewController.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Annotation.h"


@interface DetailViewController () {

    CLLocationManager *locationManager;

}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    self.title = self.location.title;
    self.titleLabel.text = self.location.title;
    self.placeLabel.text = self.location.place;
    self.typeLabel.text = self.location.type;
    self.urlLabel.text = self.location.url;
    
    _mapView.showsUserLocation = YES;
    _mapView.showsBuildings = YES;
    
    locationManager = [CLLocationManager new];
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    //map annotation
    Annotation *mapPoint = [[Annotation alloc] init];
    mapPoint.coordinate = CLLocationCoordinate2DMake([self.location.latitude doubleValue], [self.location.longitude doubleValue]);
    mapPoint.title = self.location.title;
    //adiciona no mapa
    [self.mapView addAnnotation:mapPoint];
    //zoom na região do pin
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapPoint.coordinate, 4000, 4000);
    [self.mapView setRegion:region];
    
}



#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *view = nil;
    
    static NSString *reuseIdentifier = @"MapAnnotation";
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //retorna um MKPinAnnotationView com acessorio
    view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    
    if(!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view.canShowCallout = YES;
        view.animatesDrop = YES;
        view.enabled = YES;
        view.tintColor = [UIColor orangeColor];
    }
    else {
        view.annotation = annotation;
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"car"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getDirections) forControlEvents:UIControlEventTouchUpInside];
    view.leftCalloutAccessoryView = button;
    
    return view;
}



/*directions*/
- (void)getDirections {
    Class mapItemClass = [MKMapItem class];
    
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.location.latitude doubleValue], [self.location.longitude doubleValue]);
        
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"Destino"]; //concluir a chamada do nome
        NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
        [mapItem openInMapsWithLaunchOptions:options];
    }
}



/*tipo de mapa*/
- (IBAction) setMap:(id)sender {
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            _mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            _mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            _mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}



- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:userLocation.coordinate fromEyeCoordinate:
//                           CLLocationCoordinate2DMake( userLocation.coordinate.latitude, userLocation.coordinate.longitude) eyeAltitude:7000];
//    [mapView setCamera:camera animated:YES];
}



/*volta pra localizacao do usuario*/
- (IBAction) findMyLocation:(id)sender {
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [_mapView setUserTrackingMode:(MKUserTrackingModeFollow) animated:YES];
}



-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *pr = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        pr.strokeColor = [UIColor redColor];
        pr.lineWidth = 5;
        return pr;
    }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
