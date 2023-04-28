//
//  SWGHistory.m
//  AFNetworking
//
//  Created by Mumtaz, Atiq on 22.11.19.
//

#import "SWGHistory.h"

@implementation SWGEvent
    @synthesize _id, tag_id, uid, cycle_ts, event, lat, longitude, deviceid, status, created_at, updated_at;

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize property's default value, if any

    }
    return self;
}

/**
 * Maps json key to property name.
 * This method is used by `JSONModel`.
 */
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"_id": @"id", @"tag_id": @"tag_id", @"uid": @"uid", @"cycle_ts": @"cycle_ts", @"event": @"event", @"lat": @"lat", @"longitude": @"long", @"deviceid": @"deviceid", @"status": @"status", @"created_at": @"created_at", @"updated_at": @"updated_at" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {

    NSArray *optionalProperties = @[];
    return [optionalProperties containsObject:propertyName];
}

@end






@implementation SWGHistory
    @synthesize cycles;

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize property's default value, if any

    }
    return self;
}

/**
 * Maps json key to property name.
 * This method is used by `JSONModel`.
 */
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"cycles": @"cycles"}];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {

    NSArray *optionalProperties = @[];
    return [optionalProperties containsObject:propertyName];
}

@end
