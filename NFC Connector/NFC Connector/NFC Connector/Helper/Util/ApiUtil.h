//
//  ApiUtil.h
//  NFC Connector
//
//  Created by Mehreen kanwal on 17.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SwaggerClient/SWGApiClient.h>
#import <SwaggerClient/SWGDefaultConfiguration.h>
// load models
#import <SwaggerClient/SWGCycle.h>
#import <SwaggerClient/SWGTag.h>
// load API classes for accessing endpoints
#import <SwaggerClient/SWGTagApi.h>

#import "Util.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApiUtil : NSObject
+ (SWGTagApi*) getApiInstance;

+ (void) getPowerConsumptionWithTagId: (NSString*) tagId completionHandler:(void (^)(SWGPowerConsumption *output, NSError* error)) handler;

+ (void) updateTagPowerStatus : (SWGTag*) tag powerStatus:(NSString*) powerValue completionHandler: (void (^)(SWGTag* output, NSError* error)) handler;

+ (void) getTagWithId : (NSString*) tagUId lat:(NSNumber*)latitude _long:(NSNumber*)longitude completionHandler: (void (^)(SWGTag* output, NSError* error)) handler;


+ (void) getHistoryWithTag: (NSString*) tagId
         completionHandler: (void (^)(SWGHistory* output, NSError* error)) handler;



///////////////// EVENTS ////////////////
+ (void) createEventWithTag: (NSString*) tagId
              lat: (NSNumber*) lat
            _long: (NSNumber*) _long
        eventCode: (NSString*) eCode
completionHandler: (void (^)(SWGTag* output, NSError* error)) handler;

+(void) createNotAllowedEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
            completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler;

+(void) createConnectorInfoPageEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
                   completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler;

+(void) createProductInfoPageEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
                 completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler;

+(void) createProductDataEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
             completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler;

+(void) createConnectorDataEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
               completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler;

+(void) useCycle: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler;

+(void) registerSterilizationCycle: (NSString*) tagId
                               lat: (NSNumber*) lat
                             _long: (NSNumber*) _long
                 completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler;
@end

NS_ASSUME_NONNULL_END

