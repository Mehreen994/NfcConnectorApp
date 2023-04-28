//
//  Cycle.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 18.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cycle : NSObject

@property (nonatomic) NSNumber* tag_id;
@property (nonatomic) NSString* u_id;
@property (nonatomic) NSNumber* longitude;
@property (nonatomic) NSNumber* latitude;
@property (nonatomic) NSString* deviceId;
@property (nonatomic) NSNumber* eventCode;
@property (nonatomic) NSNumber* statusCode;
@property (nonatomic) NSString* createdAt;
@property (nonatomic) NSNumber* cycleId;
@property (nonatomic) NSString* updatedAt;
@property (nonatomic) NSString* cycleTs;

- (void) setUpValuesWithTagId:(NSNumber*) tagId UID:(NSString*) uid longitude:(NSNumber*) longitude latitude:(NSNumber*) latitude deviceId:(NSString*) deviceId
                    eventCode:(NSNumber*) eventCode statusCode:(NSNumber*) status createdA:(NSString*) created cycleId:(NSNumber*) cycleId updatedAt:(NSString*) updatedAt cycleTs:(NSString*) cycleTs;

 +(Cycle*) sharedObject;
-(void) parseDictionary: (NSDictionary*) dict;
@end

#define CycleShared Cycle.sharedObject

NS_ASSUME_NONNULL_END
