//
//  SWGPowerConsumption.m
//  AFNetworking
//
//  Created by Mumtaz, Atiq on 08.12.19.
//

#import "SWGPowerConsumption.h"

@implementation SWGPowerConsumption
@synthesize powerConsumption;
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
  return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"powerConsumption": @"power_consumption" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}

@end
