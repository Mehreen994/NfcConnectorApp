//
//  Cycle.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 18.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "Cycle.h"

@implementation Cycle

+(Cycle*) sharedObject {
    static Cycle* sharedObject;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
        [sharedObject setUpValuesWithTagId:[NSNumber numberWithInt:0] UID:@"" longitude:[NSNumber numberWithInt:0] latitude:[NSNumber numberWithInt:0] deviceId:@"" eventCode:[NSNumber numberWithInt:0] statusCode:[NSNumber numberWithInt:0] createdA:@"" cycleId:[NSNumber numberWithInt:0] updatedAt:@"" cycleTs:@""];
    });

    return sharedObject;
}

- (void) setUpValuesWithTagId:(NSNumber*) tagId UID:(NSString*) uid longitude:(NSNumber*) longitude latitude:(NSNumber*) latitude deviceId:(NSString*) deviceId
                    eventCode:(NSNumber*) eventCode statusCode:(NSNumber*) status createdA:(NSString*) created cycleId:(NSNumber*) cycleId updatedAt:(NSString*) updatedAt cycleTs:(NSString*) cycleTs {
    self.tag_id = tagId;
    self.u_id = uid;
    self.longitude = longitude;
    self.latitude = latitude;
    self.deviceId = deviceId;
    self.eventCode = eventCode;
    self.statusCode = status;
    self.createdAt = created;
    self.cycleId = cycleId;
    self.updatedAt = updatedAt;
    self.cycleTs = cycleTs;
}

-(void) parseDictionary: (NSDictionary*) dict {
    self.tag_id = (NSNumber*) [dict valueForKey:@"tag_id"];
    self.u_id = (NSString*) [dict valueForKey:@"uid"];
    self.longitude = (NSNumber*) [dict valueForKey:@"long"];
    self.deviceId = (NSString*)[dict valueForKey:@"deviceid"];
    self.eventCode = (NSNumber*)[dict valueForKey:@"event"];
    self.statusCode = (NSNumber*)[dict valueForKey:@"status"];
    self.createdAt = (NSString*)[dict valueForKey:@"created_at"];
    self.cycleId = (NSNumber*)[dict valueForKey:@"id"];
    self.latitude = (NSNumber*) [dict valueForKey:@"lat"];
    self.updatedAt = (NSString*)[dict valueForKey:@"updated_at"];
    self.cycleTs = (NSString*)[dict valueForKey:@"cycle_ts"];

}
@end
