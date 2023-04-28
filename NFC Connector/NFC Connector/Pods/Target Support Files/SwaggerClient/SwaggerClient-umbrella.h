#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SWGTagApi.h"
#import "JSONValueTransformer+ISO8601.h"
#import "SWGApi.h"
#import "SWGApiClient.h"
#import "SWGBasicAuthTokenProvider.h"
#import "SWGConfiguration.h"
#import "SWGDefaultConfiguration.h"
#import "SWGJSONRequestSerializer.h"
#import "SWGLogger.h"
#import "SWGObject.h"
#import "SWGQueryParamCollection.h"
#import "SWGResponseDeserializer.h"
#import "SWGSanitizer.h"
#import "JSONModel.h"
#import "JSONModelClassProperty.h"
#import "JSONModelError.h"
#import "JSONModelLib.h"
#import "JSONAPI.h"
#import "JSONHTTPClient.h"
#import "JSONModel+networking.h"
#import "JSONKeyMapper.h"
#import "JSONValueTransformer.h"
#import "SWGCycle.h"
#import "SWGHistory.h"
#import "SWGPowerConsumption.h"
#import "SWGTag.h"

FOUNDATION_EXPORT double SwaggerClientVersionNumber;
FOUNDATION_EXPORT const unsigned char SwaggerClientVersionString[];

