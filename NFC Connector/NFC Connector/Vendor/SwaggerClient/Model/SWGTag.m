#import "SWGTag.h"

@implementation SWGTag

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
  return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"_id": @"id", @"uid": @"uid", @"power_status": @"power_status", @"confectionCode": @"confection_code", @"customerNo": @"customer_no", @"oduCustomerNo": @"odu_customer_no", @"connectorproductionDate": @"connectorproduction_date", @"businessCode": @"business_code", @"linkConnector": @"link_connector", @"productionDate": @"production_date", @"validTo": @"valid_to", @"productDesc": @"product_desc", @"regionCode": @"region_code", @"linkProduct": @"link_product", @"linkReplacement": @"link_replacement", @"statusSterilization": @"status_sterilization", @"maxUsecycles": @"max_usecycles", @"maxSterilization": @"max_sterilization", @"alertStatus": @"alert_status", @"deleted": @"deleted", @"createdAt": @"created_at", @"updatedAt": @"updated_at", @"useCycles": @"use_cycles", @"customer_name": @"customer_name", @"useSterilization": @"use_sterilization" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {

  NSArray *optionalProperties = @[@"businessCode", ];
  return [optionalProperties containsObject:propertyName];
}

@end
