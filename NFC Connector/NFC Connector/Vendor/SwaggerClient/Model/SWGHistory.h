//
//  SWGHistory.h
//  AFNetworking
//
//  Created by Mumtaz, Atiq on 22.11.19.
//

#import <Foundation/Foundation.h>
#import "SWGObject.h"

@interface SWGEvent : SWGObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* tag_id;
@property(nonatomic) NSString* uid;
@property(nonatomic) NSString* cycle_ts;
@property(nonatomic) NSString* event;
@property(nonatomic) NSString* lat;
@property(nonatomic) NSString* longitude;
@property(nonatomic) NSString* deviceid;
@property(nonatomic) NSString* status;
@property(nonatomic) NSString* created_at;
@property(nonatomic) NSString* updated_at;
@end

@interface SWGHistory : SWGObject

@property(nonatomic) NSMutableArray* cycles;

@end

