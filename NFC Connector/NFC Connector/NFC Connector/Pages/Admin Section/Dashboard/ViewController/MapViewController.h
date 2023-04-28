//
//  MapViewController.h
//  NFC Connector
//
//  Created by Mehreen kanwal  on 24.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiUtil.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MapMarkerWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController<GMSMapViewDelegate, MapMarkerWindowProtocol>
@property (weak, nonatomic) IBOutlet UIView *mapViewContainer;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) SWGHistory* history;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@end

NS_ASSUME_NONNULL_END
