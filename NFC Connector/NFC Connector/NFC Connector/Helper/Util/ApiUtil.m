//
//  ApiUtil.m
//  NFC Connector
//
//  Created by Mehreen Kanwal on 17.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "ApiUtil.h"
#import "ProgressHUD.h"
#import "AFNetworking.h"

@implementation ApiUtil
//cycleReceived
+ (SWGTagApi*) getApiInstance {

    NSString* prefix = @"https://odin.rassware.de/auguris/api/V1/";
    NSURL* url = [[NSURL alloc] initWithString:prefix];
    SWGDefaultConfiguration* config = [SWGDefaultConfiguration sharedConfig];

   // [config setDebug:YES];

    SWGApiClient * client = [[SWGApiClient alloc] initWithBaseURL:url configuration: config];
    SWGTagApi *apiInstance = [[SWGTagApi alloc] initWithApiClient:client];
    [apiInstance setDefaultHeaderValue:@"Basic ZGV2b3A6U3RhcnQjMTIz" forKey:@"Authorization"];

    return apiInstance;
}

+ (NSString*) getUniqueString
{
    NSString *thisDeviceID;
    NSString *systemVersion = [[UIDevice currentDevice]systemVersion];
    NSString *model = [[UIDevice currentDevice] model];



    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        thisDeviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    else
    {
        CFStringRef cfUuid = CFUUIDCreateString(NULL, CFUUIDCreate(NULL));
        thisDeviceID = (__bridge NSString *)cfUuid;
        CFRelease(cfUuid);
    }


   // NSLog(@"UUID = %@", thisDeviceID);
    NSString* globalDeviceID = [NSString stringWithFormat:@"%@-OS %@-%@",thisDeviceID,systemVersion,model];
    NSLog(@"Device Id = %@", globalDeviceID);
    return globalDeviceID;
}

+ (void) getPowerConsumptionWithTagId: (NSString*) tagId completionHandler:(void (^)(SWGPowerConsumption *output, NSError* error)) handler {
    [ProgressHUD show];
    SWGTagApi *apiInstance = [ApiUtil getApiInstance];

    [apiInstance tagGetPowerConsumptionWithTagId:tagId completionHandler:^(SWGPowerConsumption *output, NSError *error) {
        NSLog(@"tagGetPowerConsumptionWithTagId request finished.");
        [ProgressHUD dismiss];
        handler(output, error);
    }];
}
+ (void) getTagWithId : (NSString*) tagUId lat:(NSNumber*)latitude _long:(NSNumber*)longitude completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {

    [ProgressHUD show];
    SWGTagApi *apiInstance = [ApiUtil getApiInstance];

    [apiInstance tagGetTagIdGetWithTagId:tagUId lat:latitude _long:longitude completionHandler:^(SWGTag *output, NSError *error) {
         NSLog(@"getTagWithId request finished.");
         [ProgressHUD dismiss];
         handler(output, error);
    }];
}

+ (void) updateTagPowerStatus : (SWGTag*) tag powerStatus:(NSString*) powerValue completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {

    [ProgressHUD show];
    SWGTagApi *apiInstance = [ApiUtil getApiInstance];

    [apiInstance updatePowerStatusWithTag:tag powerStatus:powerValue completionHandler:^(SWGTag *output, NSError *error) {
        NSLog(@"updatePowerStatusWithTag request finished.");
        [ProgressHUD dismiss];
        handler(output, error);
    }];

}

+ (void) getHistoryWithTag: (NSString*) tagId
          completionHandler: (void (^)(SWGHistory* output, NSError* error)) handler {

    [ProgressHUD show];
    SWGTagApi *apiInstance = [ApiUtil getApiInstance];

    [apiInstance getTagHistoryWithTagId:tagId completionHandler:^(SWGHistory *output, NSError *error) {
        [ProgressHUD dismiss];
        if (output) {
            SWGHistory *history = [Util parseDictionaryToHistory:output.cycles];
            handler(history, error);
        } else {
            handler(output, error);
        }

    }];


}

+ (void) createEventWithTag: (NSString*) tagId
                                   lat: (NSNumber*) lat
                                 _long: (NSNumber*) _long
                             eventCode: (NSString*) eCode
                     completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {

    [ProgressHUD show];
    SWGTagApi *apiInstance = [ApiUtil getApiInstance];

    [apiInstance createEventWithTag:tagId lat:lat _long:_long userId:[self getUniqueString] eventCode:eCode completionHandler:^(SWGTag *output, NSError *error) {
        [ProgressHUD dismiss];
        handler(output, error);
    }];

}

+(void) useCycle: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler {

    [self createEventWithTag:tagId lat:lat _long:_long eventCode:@"2" completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        handler (output, error);
    }];
    
}

+(void) registerSterilizationCycle: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler {

    [self createEventWithTag:tagId lat:lat _long:_long eventCode:@"3" completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        handler (output, error);
    }];
}

+(void) createConnectorInfoPageEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler {

    [self createEventWithTag:tagId lat:lat _long:_long eventCode:@"5" completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        handler (output, error);
    }];
}

+(void) createProductInfoPageEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler {

    [self createEventWithTag:tagId lat:lat _long:_long eventCode:@"4" completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        handler (output, error);
    }];
}

+(void) createProductDataEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler {

    [self createEventWithTag:tagId lat:lat _long:_long eventCode:@"9" completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        handler (output, error);
    }];
}

+(void) createConnectorDataEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler {

    [self createEventWithTag:tagId lat:lat _long:_long eventCode:@"10" completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        handler (output, error);
    }];
}

+(void) createNotAllowedEvent: (NSString*) tagId
             lat: (NSNumber*) lat
           _long: (NSNumber*) _long
completionHandler: (void (^)(SWGTag* output1, NSError* error1)) handler {

    [self createEventWithTag:tagId lat:lat _long:_long eventCode:@"8" completionHandler:^(SWGTag * _Nonnull output, NSError * _Nonnull error) {
        handler (output, error);
    }];
}
@end
