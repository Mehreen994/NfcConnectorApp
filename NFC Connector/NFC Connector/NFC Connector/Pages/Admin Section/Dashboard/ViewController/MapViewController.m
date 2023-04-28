//
//  MapViewController.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 24.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "MapViewController.h"
#import "Util.h"
#import "HistoryDetailViewController.h"
#import "AdminStartViewController.h"

@interface MapViewController () {
    MapMarkerWindow* infoWindow;
    GMSMarker* locationMarker;
    BOOL mapLoaded;
}
@end

@implementation MapViewController
@synthesize history;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    infoWindow = (MapMarkerWindow*) [MapMarkerWindow instanceFromNib];
    [infoWindow setDelegate:self];
    mapLoaded = NO;
}

-(void) viewDidAppear:(BOOL)animated {
    if (!mapLoaded) {
        mapLoaded = YES;
        [self loadMapView];
    }

}
- (IBAction)backButtonPressed:(id)sender {
    for(UIViewController* controller in [self.navigationController viewControllers]) {
        if ([controller isKindOfClass:[AdminStartViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

- (void) infoWindowViewButtonClicked {
    NSLog(@"buttn clicked ");
    [self performSegueWithIdentifier:@"showDetail" sender:locationMarker.userData];
}
- (void)loadMapView {
    BOOL cameraPositionSet = NO;
    int eventsWhichHasZeroLat = 0;
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:52.52437
                                                            longitude:13.41053
                                                                 zoom:0];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.mapViewContainer.frame.size.width, self.mapViewContainer.frame.size.height) camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    //mapView.center = self.mapViewContainer.center;
    [self.mapViewContainer addSubview:mapView];

    for (SWGEvent* event in history.cycles) {
        double latVal = [event.lat doubleValue];
        double longVal = [event.longitude doubleValue];

        if (latVal != 0.0 && longVal != 0.0) {
            if (!cameraPositionSet) {
                camera = [GMSCameraPosition cameraWithLatitude:latVal
                                                     longitude:longVal
                                                          zoom:0];
                mapView.camera = camera;
                cameraPositionSet = YES;
            }

            // Creates a marker in the center of the map.
            GMSMarker *marker = [[GMSMarker alloc] init];
            CLLocationCoordinate2D point;
            point.latitude = latVal;
            point.longitude = longVal;
            marker.position = point;
            marker.userData = event;

            marker.map = mapView;

        } else {
            eventsWhichHasZeroLat += 1;
        }
    }

    _infoLabel.text = [NSString stringWithFormat:@"%d events recorded without Location.", eventsWhichHasZeroLat];

    if (eventsWhichHasZeroLat <= 0 ) {
        _heightConstraint.constant = 0.1f;
        mapView.frame = CGRectMake(0, 0, self.mapViewContainer.frame.size.width, self.mapViewContainer.frame.size.height + 50);
        [UIView animateWithDuration:1.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }

}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position {
    if (locationMarker != nil) {
        CGPoint point = [mapView.projection pointForCoordinate:locationMarker.position];
        point.y = point.y - 140;
        infoWindow.center = point;
    }
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [infoWindow removeFromSuperview];
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {

    locationMarker = marker;

    [infoWindow removeFromSuperview];
    infoWindow = (MapMarkerWindow*) [MapMarkerWindow instanceFromNib];
    [infoWindow setDelegate:self];

    // Offset the info window to be directly above the tapped marker
    CGPoint point = [mapView.projection pointForCoordinate:locationMarker.position];
    point.y = point.y - 140;
    infoWindow.center = point;
    [mapView addSubview:infoWindow];

    infoWindow.alpha = 0.9;
    infoWindow.layer.cornerRadius = 12;
    infoWindow.layer.borderWidth = 2;
    infoWindow.layer.borderColor = [UIColor colorWithRed:54.0/255.0 green:124.0/255.0 blue:169.0/255.0 alpha:1.0].CGColor;

    // marker userData
    SWGEvent* event = (SWGEvent*) marker.userData;
    infoWindow.titleLabel.text = [Util getEventCode:event.event];
    infoWindow.dateLabel.text = event.created_at;
    infoWindow.descriptionLabel.text = event.deviceid;
    infoWindow.subDescriptionLabel.text = [Util getStatusCode:event.status];

    return false;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        HistoryDetailViewController* controller = (HistoryDetailViewController*) segue.destinationViewController;
        controller.eventObject = (SWGEvent*)sender;
    }
}


@end
