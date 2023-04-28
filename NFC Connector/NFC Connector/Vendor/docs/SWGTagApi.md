# SWGTagApi

All URIs are relative to *https://odin.rassware.de/auguris/V1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**tagCreatePost**](SWGTagApi.md#tagcreatepost) | **POST** /tag/create | Add a new Tag
[**tagGetTagIdGet**](SWGTagApi.md#taggettagidget) | **GET** /tag/get/{tagId} | Returns a Tag
[**tagSterilizationTagIdPost**](SWGTagApi.md#tagsterilizationtagidpost) | **POST** /tag/sterilization/{tagId} | Add a new sterilization
[**tagUpdateTagIdDelete**](SWGTagApi.md#tagupdatetagiddelete) | **DELETE** /tag/update/{tagId} | Deletes a tag
[**tagUpdateTagIdPost**](SWGTagApi.md#tagupdatetagidpost) | **POST** /tag/update/{tagId} | Posts tag info
[**tagUsecycleTagIdPost**](SWGTagApi.md#tagusecycletagidpost) | **POST** /tag/usecycle/{tagId} | Add a new cycle


# **tagCreatePost**
```objc
-(NSURLSessionTask*) tagCreatePostWithBody: (SWGTag*) body
        completionHandler: (void (^)(NSError* error)) handler;
```

Add a new Tag

Creates a new Tag in the database

### Example 
```objc
SWGDefaultConfiguration *apiConfig = [SWGDefaultConfiguration sharedConfig];

// Configure API key authorization: (authentication scheme: api_key)
[apiConfig setApiKey:@"YOUR_API_KEY" forApiKeyIdentifier:@"api_key"];
// Uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//[apiConfig setApiKeyPrefix:@"Bearer" forApiKeyIdentifier:@"api_key"];


SWGTag* body = [[SWGTag alloc] init]; // Tag object that needs to be added to the database

SWGTagApi*apiInstance = [[SWGTagApi alloc] init];

// Add a new Tag
[apiInstance tagCreatePostWithBody:body
          completionHandler: ^(NSError* error) {
                        if (error) {
                            NSLog(@"Error calling SWGTagApi->tagCreatePost: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**SWGTag***](SWGTag.md)| Tag object that needs to be added to the database | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tagGetTagIdGet**
```objc
-(NSURLSessionTask*) tagGetTagIdGetWithTagId: (NSString*) tagId
        completionHandler: (void (^)(SWGTag* output, NSError* error)) handler;
```

Returns a Tag

Returns a Tag from the database

### Example 
```objc
SWGDefaultConfiguration *apiConfig = [SWGDefaultConfiguration sharedConfig];

// Configure API key authorization: (authentication scheme: api_key)
[apiConfig setApiKey:@"YOUR_API_KEY" forApiKeyIdentifier:@"api_key"];
// Uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//[apiConfig setApiKeyPrefix:@"Bearer" forApiKeyIdentifier:@"api_key"];


NSString* tagId = @"tagId_example"; // ID of tag to return

SWGTagApi*apiInstance = [[SWGTagApi alloc] init];

// Returns a Tag
[apiInstance tagGetTagIdGetWithTagId:tagId
          completionHandler: ^(SWGTag* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGTagApi->tagGetTagIdGet: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tagId** | **NSString***| ID of tag to return | 

### Return type

[**SWGTag***](SWGTag.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tagSterilizationTagIdPost**
```objc
-(NSURLSessionTask*) tagSterilizationTagIdPostWithTagId: (NSString*) tagId
    lat: (NSNumber*) lat
    _long: (NSNumber*) _long
        completionHandler: (void (^)(SWGTag* output, NSError* error)) handler;
```

Add a new sterilization

Adds a new sterilization to a Tag in the database

### Example 
```objc
SWGDefaultConfiguration *apiConfig = [SWGDefaultConfiguration sharedConfig];

// Configure API key authorization: (authentication scheme: api_key)
[apiConfig setApiKey:@"YOUR_API_KEY" forApiKeyIdentifier:@"api_key"];
// Uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//[apiConfig setApiKeyPrefix:@"Bearer" forApiKeyIdentifier:@"api_key"];


NSString* tagId = @"tagId_example"; // Tag id to sterilize
NSNumber* lat = @8.14; // Current latitude of tag
NSNumber* _long = @8.14; // Current latitude of tag

SWGTagApi*apiInstance = [[SWGTagApi alloc] init];

// Add a new sterilization
[apiInstance tagSterilizationTagIdPostWithTagId:tagId
              lat:lat
              _long:_long
          completionHandler: ^(SWGTag* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGTagApi->tagSterilizationTagIdPost: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tagId** | **NSString***| Tag id to sterilize | 
 **lat** | **NSNumber***| Current latitude of tag | 
 **_long** | **NSNumber***| Current latitude of tag | 

### Return type

[**SWGTag***](SWGTag.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tagUpdateTagIdDelete**
```objc
-(NSURLSessionTask*) tagUpdateTagIdDeleteWithTagId: (NSString*) tagId
        completionHandler: (void (^)(NSError* error)) handler;
```

Deletes a tag



### Example 
```objc
SWGDefaultConfiguration *apiConfig = [SWGDefaultConfiguration sharedConfig];

// Configure API key authorization: (authentication scheme: api_key)
[apiConfig setApiKey:@"YOUR_API_KEY" forApiKeyIdentifier:@"api_key"];
// Uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//[apiConfig setApiKeyPrefix:@"Bearer" forApiKeyIdentifier:@"api_key"];


NSString* tagId = @"tagId_example"; // Tag id to delete

SWGTagApi*apiInstance = [[SWGTagApi alloc] init];

// Deletes a tag
[apiInstance tagUpdateTagIdDeleteWithTagId:tagId
          completionHandler: ^(NSError* error) {
                        if (error) {
                            NSLog(@"Error calling SWGTagApi->tagUpdateTagIdDelete: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tagId** | **NSString***| Tag id to delete | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tagUpdateTagIdPost**
```objc
-(NSURLSessionTask*) tagUpdateTagIdPostWithTagId: (NSString*) tagId
    lat: (NSNumber*) lat
    _long: (NSNumber*) _long
        completionHandler: (void (^)(SWGTag* output, NSError* error)) handler;
```

Posts tag info

Returns tag location to DB

### Example 
```objc
SWGDefaultConfiguration *apiConfig = [SWGDefaultConfiguration sharedConfig];

// Configure API key authorization: (authentication scheme: api_key)
[apiConfig setApiKey:@"YOUR_API_KEY" forApiKeyIdentifier:@"api_key"];
// Uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//[apiConfig setApiKeyPrefix:@"Bearer" forApiKeyIdentifier:@"api_key"];


NSString* tagId = @"tagId_example"; // ID of tag to return
NSNumber* lat = @8.14; // Current latitude of tag
NSNumber* _long = @8.14; // Current latitude of tag

SWGTagApi*apiInstance = [[SWGTagApi alloc] init];

// Posts tag info
[apiInstance tagUpdateTagIdPostWithTagId:tagId
              lat:lat
              _long:_long
          completionHandler: ^(SWGTag* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGTagApi->tagUpdateTagIdPost: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tagId** | **NSString***| ID of tag to return | 
 **lat** | **NSNumber***| Current latitude of tag | 
 **_long** | **NSNumber***| Current latitude of tag | 

### Return type

[**SWGTag***](SWGTag.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tagUsecycleTagIdPost**
```objc
-(NSURLSessionTask*) tagUsecycleTagIdPostWithTagId: (NSString*) tagId
    lat: (NSNumber*) lat
    _long: (NSNumber*) _long
        completionHandler: (void (^)(SWGTag* output, NSError* error)) handler;
```

Add a new cycle

Adds a new cycle to a Tag in the database

### Example 
```objc
SWGDefaultConfiguration *apiConfig = [SWGDefaultConfiguration sharedConfig];

// Configure API key authorization: (authentication scheme: api_key)
[apiConfig setApiKey:@"YOUR_API_KEY" forApiKeyIdentifier:@"api_key"];
// Uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//[apiConfig setApiKeyPrefix:@"Bearer" forApiKeyIdentifier:@"api_key"];


NSString* tagId = @"tagId_example"; // Tag id to (use) cycle up
NSNumber* lat = @8.14; // Current latitude of tag
NSNumber* _long = @8.14; // Current latitude of tag

SWGTagApi*apiInstance = [[SWGTagApi alloc] init];

// Add a new cycle
[apiInstance tagUsecycleTagIdPostWithTagId:tagId
              lat:lat
              _long:_long
          completionHandler: ^(SWGTag* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGTagApi->tagUsecycleTagIdPost: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tagId** | **NSString***| Tag id to (use) cycle up | 
 **lat** | **NSNumber***| Current latitude of tag | 
 **_long** | **NSNumber***| Current latitude of tag | 

### Return type

[**SWGTag***](SWGTag.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

