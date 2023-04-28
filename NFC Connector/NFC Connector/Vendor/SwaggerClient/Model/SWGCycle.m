#import "SWGCycle.h"

@implementation SWGCycle

- (instancetype)init {
  self = [super init];
  if (self) {
    // initialize property's default value, if any
    
  }
  return self;
}

- (instancetype)initWithTagId: (NSNumber*) tagId {
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
  return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"tagId": @"tag_id", @"uid": @"uid", @"cycleTs": @"cycle_ts", @"event": @"event", @"lat": @"lat", @"_long": @"long", @"deviceid": @"deviceid", @"status": @"status", @"updatedAt": @"updated_at", @"createdAt": @"created_at", @"_id": @"id" }];
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
