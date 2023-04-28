//
//  Location.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 26.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

NS_ASSUME_NONNULL_BEGIN
@protocol LocationProtocolDelegate <NSObject>
-(void)onLocationFound: (CLLocationCoordinate2D) coordinate calledBy:(NSString*) call tag:(NSString*) tag_id;
@end




@interface Location : NSObject <CLLocationManagerDelegate>
    +(Location*) sharedObject;
    -(void) getLocation:(NSString*) calledBy tag:(NSString*) tid;

    @property(nonatomic, strong) NSString* caller;
    @property(nonatomic, strong) NSString* tagId;
    @property(nonatomic, strong) CLLocationManager* locationManager;
    @property(nonatomic)id< LocationProtocolDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
#define LOCATION Location.sharedObject
