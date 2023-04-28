//
//  MapMarkerWindow.m
//  NFC Connector
//
//  Created by Mehreen kanwal  on 25.11.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "MapMarkerWindow.h"

@interface MapMarkerWindow() {
     id delegate;
}
@end
@implementation MapMarkerWindow

+(UIView*) instanceFromNib {
    return [[UINib nibWithNibName:@"MapMarkerWindowView" bundle:nil] instantiateWithOwner:self options:nil].firstObject;
}

- (void) setDelegate:(id)newDelegate {
    delegate = newDelegate;
}

- (IBAction)buttonClicked:(id)sender {
    [delegate infoWindowViewButtonClicked];
}

@end
