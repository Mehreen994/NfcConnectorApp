#import "SWGTagApi.h"
#import "SWGQueryParamCollection.h"
#import "SWGApiClient.h"
#import "SWGTag.h"
#import "SWGHistory.h"

@interface SWGTagApi ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *mutableDefaultHeaders;

@end

@implementation SWGTagApi

NSString* kSWGTagApiErrorDomain = @"SWGTagApiErrorDomain";
NSInteger kSWGTagApiMissingParamErrorCode = 234513;

@synthesize apiClient = _apiClient;

#pragma mark - Initialize methods

- (instancetype) init {
    return [self initWithApiClient:[SWGApiClient sharedClient]];
}


-(instancetype) initWithApiClient:(SWGApiClient *)apiClient {
    self = [super init];
    if (self) {
        _apiClient = apiClient;
        _mutableDefaultHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -

-(NSString*) defaultHeaderForKey:(NSString*)key {
    return self.mutableDefaultHeaders[key];
}

-(void) setDefaultHeaderValue:(NSString*) value forKey:(NSString*)key {
    [self.mutableDefaultHeaders setValue:value forKey:key];
}

-(NSDictionary *)defaultHeaders {
    return self.mutableDefaultHeaders;
}

#pragma mark - Api Methods

///
/// Add a new Tag
/// Creates a new Tag in the database
///  @param body Tag object that needs to be added to the database 
///
///  @returns void
///
-(NSURLSessionTask*) tagCreatePostWithBody: (SWGTag*) body
    completionHandler: (void (^)(NSError* error)) handler {
    // verify the required parameter 'body' is set
    if (body == nil) {
        NSParameterAssert(body);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"body"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/create"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    bodyParam = body;

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: nil
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler(error);
                                }
                            }];
}


///
/// Returns a Tag
/// Returns a Power Consumption from the database
///  @param tagId ID of tag to return
///
///  @returns PowerConsumption*
///
-(NSURLSessionTask*) tagGetPowerConsumptionWithTagId: (NSString*) tagId
    completionHandler: (void (^)(SWGPowerConsumption* output, NSError* error)) handler {
    // verify the required parameter 'tagId' is set
    if (tagId == nil) {
        NSParameterAssert(tagId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"tagId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/power_consumption/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tagId != nil) {
        pathParams[@"tagId"] = tagId;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGPowerConsumption*"
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler((SWGPowerConsumption*)data, error);
                                }
                            }];
}

///
/// Returns a Tag
/// Returns a Tag from the database
///  @param tagId ID of tag to return 
///
///  @returns SWGTag*
///
-(NSURLSessionTask*) tagGetTagIdGetWithTagId: (NSString*) tagId
                                         lat: (NSNumber*) lat
                                       _long: (NSNumber*) _long
    completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {
    // verify the required parameter 'tagId' is set
    if (tagId == nil) {
        NSParameterAssert(tagId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"tagId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter 'lat' is set
    if (lat == nil) {
        NSParameterAssert(lat);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"lat"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter '_long' is set
    if (_long == nil) {
        NSParameterAssert(_long);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"_long"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/get/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tagId != nil) {
        pathParams[@"tagId"] = tagId;
    }


    
    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (lat != nil) {
        queryParams[@"lat"] = lat;
    }
    if (_long != nil) {
        queryParams[@"long"] = _long;
    }

    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"GET"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGTag*"
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler((SWGTag*)data, error);
                                }
                            }];
}

///
/// Add a new sterilization
/// Adds a new sterilization to a Tag in the database
///  @param tagId Tag id to sterilize 
///
///  @param lat Current latitude of tag 
///
///  @param _long Current latitude of tag 
///
///  @returns SWGTag*
///
-(NSURLSessionTask*) tagSterilizationTagIdPostWithTagId: (NSString*) tagId
    lat: (NSNumber*) lat
    _long: (NSNumber*) _long
    completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {
    // verify the required parameter 'tagId' is set
    if (tagId == nil) {
        NSParameterAssert(tagId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"tagId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter 'lat' is set
    if (lat == nil) {
        NSParameterAssert(lat);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"lat"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter '_long' is set
    if (_long == nil) {
        NSParameterAssert(_long);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"_long"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/sterilization/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tagId != nil) {
        pathParams[@"tagId"] = tagId;
    }
    if (lat != nil) {
        pathParams[@"lat"] = lat;
    }
    if (_long != nil) {
        pathParams[@"long"] = _long;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGTag*"
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler((SWGTag*)data, error);
                                }
                            }];
}

///
/// Deletes a tag
/// 
///  @param tagId Tag id to delete 
///
///  @returns void
///
-(NSURLSessionTask*) tagUpdateTagIdDeleteWithTagId: (NSString*) tagId
    completionHandler: (void (^)(NSError* error)) handler {
    // verify the required parameter 'tagId' is set
    if (tagId == nil) {
        NSParameterAssert(tagId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"tagId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/update/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tagId != nil) {
        pathParams[@"tagId"] = tagId;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"DELETE"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: nil
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler(error);
                                }
                            }];
}

///
/// Posts tag info
/// Returns tag location to DB
///  @param tagId ID of tag to return 
///
///  @param lat Current latitude of tag 
///
///  @param _long Current latitude of tag 
///
///  @returns SWGTag*
///
-(NSURLSessionTask*) tagUpdateTagIdPostWithTagId: (NSString*) tagId
    lat: (NSNumber*) lat
    _long: (NSNumber*) _long
    completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {
    // verify the required parameter 'tagId' is set
    if (tagId == nil) {
        NSParameterAssert(tagId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"tagId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter 'lat' is set
    if (lat == nil) {
        NSParameterAssert(lat);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"lat"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter '_long' is set
    if (_long == nil) {
        NSParameterAssert(_long);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"_long"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/update/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tagId != nil) {
        pathParams[@"tagId"] = tagId;
    }
    if (lat != nil) {
        pathParams[@"lat"] = lat;
    }
    if (_long != nil) {
        pathParams[@"long"] = _long;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGTag*"
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler((SWGTag*)data, error);
                                }
                            }];
}

-(NSURLSessionTask*) updatePowerStatusWithTag: (SWGTag*) tag powerStatus: (NSString*) powerStatus
                          completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/update/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tag.uid != nil) {
        pathParams[@"tagId"] = tag.uid;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                                         tag:tag
                               powerStatus:powerStatus
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGTag*"
                           completionBlock: ^(id data, NSError *error) {
                               if(handler) {
                                   handler((SWGTag*)data, error);
                               }
                           }];
}
///
/// gets Tag History Info
/// Returns the history of the Tag
///  @param tagId ID of the tag
///
///
///  @returns SWGTag*
///
-(NSURLSessionTask*) getTagHistoryWithTagId: (NSString*) tagId
                               completionHandler: (void (^)(SWGHistory* output, NSError* error)) handler {
    // verify the required parameter 'tagId' is set
    if (tagId == nil) {
        NSParameterAssert(tagId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"tagId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/history/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tagId != nil) {
        pathParams[@"tagId"] = tagId;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGHistory*"
                           completionBlock: ^(id data, NSError *error) {
                               if(handler) {
                                   handler((SWGHistory*)data, error);
                               }
                           }];
}

///
/// Add a new cycle
/// Adds a new cycle to a Tag in the database
///  @param tagId Tag id to (use) cycle up 
///
///  @param lat Current latitude of tag 
///
///  @param _long Current latitude of tag 
///
///  @returns SWGTag*
///
-(NSURLSessionTask*) tagUsecycleTagIdPostWithTagId: (NSString*) tagId
    lat: (NSNumber*) lat
    _long: (NSNumber*) _long
    completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {
    // verify the required parameter 'tagId' is set
    if (tagId == nil) {
        NSParameterAssert(tagId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"tagId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter 'lat' is set
    if (lat == nil) {
        NSParameterAssert(lat);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"lat"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter '_long' is set
    if (_long == nil) {
        NSParameterAssert(_long);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"_long"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/usecycle/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tagId != nil) {
        pathParams[@"tagId"] = tagId;
    }
    if (lat != nil) {
        pathParams[@"lat"] = lat;
    }
    if (_long != nil) {
        pathParams[@"long"] = _long;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGTag*"
                           completionBlock: ^(id data, NSError *error) {
                                if(handler) {
                                    handler((SWGTag*)data, error);
                                }
                            }];
}



-(NSURLSessionTask*) createEventWithTag: (NSString*) tagId
                                               lat: (NSNumber*) lat
                                             _long: (NSNumber*) _long
                                            userId: (NSString*) userId
                                 eventCode: (NSString*) eventCode
                                 completionHandler: (void (^)(SWGTag* output, NSError* error)) handler {
    // verify the required parameter 'tagId' is set
    if (tagId == nil) {
        NSParameterAssert(tagId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"tagId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter 'lat' is set
    if (lat == nil) {
        NSParameterAssert(lat);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"lat"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter '_long' is set
    if (_long == nil) {
        NSParameterAssert(_long);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"_long"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter 'userId' is set
    if (userId == nil) {
        NSParameterAssert(userId);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"userId"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }

    // verify the required parameter 'eventcode' is set
    if (eventCode == nil) {
        NSParameterAssert(eventCode);
        if(handler) {
            NSDictionary * userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:NSLocalizedString(@"Missing required parameter '%@'", nil),@"eventcode"] };
            NSError* error = [NSError errorWithDomain:kSWGTagApiErrorDomain code:kSWGTagApiMissingParamErrorCode userInfo:userInfo];
            handler(nil, error);
        }
        return nil;
    }


    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/tag/recordevent/{tagId}"];

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (tagId != nil) {
        pathParams[@"tagId"] = tagId;
    }
    if (lat != nil) {
        pathParams[@"lat"] = lat;
    }
    if (_long != nil) {
        pathParams[@"long"] = _long;
    }
    if (userId != nil) {
        pathParams[@"userId"] = userId;
    }
    if (eventCode != nil) {
        pathParams[@"actioncode"] = eventCode;
    }

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"api_token"] = @"sdfasffsdafsfsadf123";

    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.apiClient.configuration.defaultHeaders];
    [headerParams addEntriesFromDictionary:self.defaultHeaders];
    // HTTP header `Accept`
    NSString *acceptHeader = [self.apiClient.sanitizer selectHeaderAccept:@[@"application/json"]];
    if(acceptHeader.length > 0) {
        headerParams[@"Accept"] = acceptHeader;
    }

    // response content type
    NSString *responseContentType = [[acceptHeader componentsSeparatedByString:@", "] firstObject] ?: @"";

    // request content type
    NSString *requestContentType = [self.apiClient.sanitizer selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"api_key"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];

    [formParams setValue:userId forKey:@"userId"];
    [formParams setValue:eventCode forKey:@"actioncode"];
    [formParams setValue:lat forKey:@"lat"];
    [formParams setValue:_long forKey:@"long"];
    

    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"SWGTag*"
                           completionBlock: ^(id data, NSError *error) {
                               if(handler) {
                                   handler((SWGTag*)data, error);
                               }
                           }];
}


@end
